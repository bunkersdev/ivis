/*
#################################################
# File:   : upload_plan_update.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Mar 15, 2015
# Author  : Selvakalathi,Kaviyarasan 
# Comments: Business uploaded fin manual adjustments  file is tranformted and loaded to main table web                                                  ################################################ 
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

/*
## Import the macros referred in the script 
*/

REGISTER ${PHX_JAR_LOC};
IMPORT '$LOAD_FAILURE_MACRO';
IMPORT '$UPD_GAP_USR_VALIDATION_MACRO';
REGISTER ${DATAFU_JAR_LOC};

define Enumerate datafu.pig.bags.Enumerate('1');

%declare Time `date +%Y-%m-%d`;
%declare current_month `date +%m`;
%declare current_year `date +%Y`;

/*
## Load the tables needed for read and write during transformation in pig script 
*/

upload_plan_upd_gap = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.UPLOAD_PLAN_UPD_GAP' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');
web_plan_upd_gap = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.WEB_PLAN_UPD_GAP'  USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');
upload_process_summary = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.UPLOAD_PROCESS_SUMMARY' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');

stg_loc_hierarchy = LOAD '${IVIS_HIVE_DATABASE}.stg_loc_hierarchy' USING org.apache.hive.hcatalog.pig.HCatLoader();
stg_item = LOAD '${IVIS_HIVE_DATABASE}.stg_item' USING org.apache.hive.hcatalog.pig.HCatLoader();
exchange_rate_d = LOAD '${IVIS_HIVE_DATABASE}.exchange_rate_d' USING org.apache.hive.hcatalog.pig.HCatLoader(); 
stg_d56_item_no =  LOAD '${IVIS_HIVE_DATABASE}.stg_d56_item_no' USING org.apache.hive.hcatalog.pig.HCatLoader(); 
stg_primary_plant_lookup = LOAD '${IVIS_HIVE_DATABASE}.stg_primary_plant_lookup' USING org.apache.hive.hcatalog.pig.HCatLoader();


filter_unprocessed = FILTER upload_process_summary by STATUS=='IN-PROCESS' and TYPE=='PLAN_UPD_GAP';
get_uploadrecords = join upload_plan_upd_gap by UPLOAD_ID,filter_unprocessed by UPLOAD_ID  using 'replicated';

get_dataset = FOREACH get_uploadrecords GENERATE 
TRIM(upload_plan_upd_gap::AFFILIATE_CODE) as affiliate_code,
TRIM(upload_plan_upd_gap::TYPE) as type,
TRIM(upload_plan_upd_gap::YEAR) as year,
TRIM(upload_plan_upd_gap::GROUP_DESC) as group_desc,
TRIM(upload_plan_upd_gap::UPLOAD_ID) as upload_id,
TRIM(upload_plan_upd_gap::USD_VAL_JAN) as usd_val_jan,
TRIM(upload_plan_upd_gap::USD_VAL_FEB) as usd_val_feb,
TRIM(upload_plan_upd_gap::USD_VAL_MAR) as usd_val_mar,
TRIM(upload_plan_upd_gap::USD_VAL_APR) as usd_val_apr,
TRIM(upload_plan_upd_gap::USD_VAL_MAY) as usd_val_may,
TRIM(upload_plan_upd_gap::USD_VAL_JUN) as usd_val_jun,
TRIM(upload_plan_upd_gap::USD_VAL_JUL) as usd_val_jul,
TRIM(upload_plan_upd_gap::USD_VAL_AUG) as usd_val_aug,
TRIM(upload_plan_upd_gap::USD_VAL_SEP) as usd_val_sep,
TRIM(upload_plan_upd_gap::USD_VAL_OCT) as usd_val_oct,
TRIM(upload_plan_upd_gap::USD_VAL_NOV) as usd_val_nov,
TRIM(upload_plan_upd_gap::USD_VAL_DEC) as usd_val_dec,
TRIM(upload_plan_upd_gap::FILE_NAME) as file_name,
upload_plan_upd_gap::COMMENT as comment,
TRIM(upload_plan_upd_gap::CREATED_BY) as created_by,
TRIM(upload_plan_upd_gap::CREATED_DATE) as created_date;



/*
##  Uploaded userid is validated against the tables for permission and access 
*/
user_validated_dataset = user_validation(get_dataset);


/*
##  Join the upload table with stg_loc table to get affiliate desc  
*/

join_aff_code = join user_validated_dataset  by affiliate_code LEFT OUTER, stg_loc_hierarchy by level_10_code;

aff_code_validation_failure = filter join_aff_code by  (stg_loc_hierarchy::level_10_code IS NULL) or (stg_loc_hierarchy::level_10_code=='') or (SIZE(stg_loc_hierarchy::level_10_code) <= 0 ) ;
aff_code_validation_success = filter join_aff_code by  (stg_loc_hierarchy::level_10_code IS NOT NULL) or (stg_loc_hierarchy::level_10_code!='') or (SIZE(stg_loc_hierarchy::level_10_code) > 0 ) ;	

store_aff_code_fail_records = FOREACH aff_code_validation_failure GENERATE
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::affiliate_code as affiliate_code,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
'$current_month' as month,
'NULL' as sap_material_no,
user_validated_dataset::group_desc as group_desc,
user_validated_dataset::file_name as file_name,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::created_date as created_date,
user_validated_dataset::created_by as created_by;

load_failed_records(store_aff_code_fail_records,'<UPD_GAP> - Affiliate Code in uploaded data is not valid');

filter_correct_year = filter aff_code_validation_success by user_validated_dataset::year == '$current_year';

filter_incorrect_year = filter aff_code_validation_success by user_validated_dataset::year != '$current_year';


store_year_validation_fail_records = FOREACH filter_incorrect_year GENERATE 
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::affiliate_code as affiliate_code,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
'$current_month' as month,
'NULL' as sap_material_no,
user_validated_dataset::group_desc as group_desc,
user_validated_dataset::file_name as file_name,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::created_date as created_date,
user_validated_dataset::created_by as created_by;

load_failed_records(store_year_validation_fail_records,'<UPD_GAP> - Uploaded data does not have current year ');


store_year_validation_passed_records = FOREACH filter_correct_year GENERATE 
user_validated_dataset::affiliate_code as affiliate_code,
stg_loc_hierarchy::level_10_desc as affiliate_desc,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
user_validated_dataset::group_desc as group_desc,
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::usd_val_jan as usd_val_jan,
user_validated_dataset::usd_val_feb as usd_val_feb,
user_validated_dataset::usd_val_mar as usd_val_mar,
user_validated_dataset::usd_val_apr as usd_val_apr,
user_validated_dataset::usd_val_may as usd_val_may,
user_validated_dataset::usd_val_jun as usd_val_jun,
user_validated_dataset::usd_val_jul as usd_val_jul,
user_validated_dataset::usd_val_aug as usd_val_aug,
user_validated_dataset::usd_val_sep as usd_val_sep,
user_validated_dataset::usd_val_oct as usd_val_oct,
user_validated_dataset::usd_val_nov as usd_val_nov,
user_validated_dataset::usd_val_dec as usd_val_dec,
user_validated_dataset::file_name as file_name,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::comment as comment,
user_validated_dataset::created_by as created_by,
user_validated_dataset::created_date as created_date;


filter_incorrect_comment_length = filter store_year_validation_passed_records by SIZE(comment) > 100;

filter_correct_comment_length = filter store_year_validation_passed_records by (SIZE(comment) <= 100) or (comment IS NULL) or (comment=='');

store_commentlength_validation_fail_records = FOREACH filter_incorrect_comment_length GENERATE
upload_id as upload_id,
affiliate_code as affiliate_code,
type as type,
year as year,
'$current_month' as month,
'NULL' as sap_material_no,
group_desc as group_desc,
file_name as file_name,
usr_eml_id as usr_eml_id,
created_date as created_date,
created_by as created_by;

load_failed_records(store_commentlength_validation_fail_records,'<UPD_GAP> - Uploaded data comments greater than 100 character ');


filter_correct_type = filter filter_correct_comment_length by (UPPER(type)=='UPDATE-GAP') or (UPPER(type)=='PLAN-GAP')  ;
filter_incorrect_type = filter filter_correct_comment_length by (UPPER(type)!='UPDATE-GAP') and (UPPER(type)!='PLAN-GAP')  ;


store_type_validation_fail_records = FOREACH filter_incorrect_type GENERATE 
upload_id as upload_id,
affiliate_code as affiliate_code,
type as type,
year as year,
'$current_month' as month,
'NULL' as sap_material_no,
group_desc as group_desc,
file_name as file_name,
usr_eml_id as usr_eml_id,
created_date as created_date,
created_by as created_by;

load_failed_records(store_type_validation_fail_records,'<UPD_GAP> - Uploaded data type not in UPDATE-GAP or PLAN-GAP ');

filter_d56_item_no_prod_type = FILTER stg_d56_item_no by prod_type=='Y';

d56_item_no_group_desc = FOREACH filter_d56_item_no_prod_type GENERATE 
UPPER(groupdesc) as group_desc,
CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(invtype,'-'),CONCAT(listno,'-')),CONCAT(labelcode,'-')),CONCAT(sizecode,'-')),packsize) as d56_item_no;

get_default_d56 = FILTER  d56_item_no_group_desc by UPPER(group_desc)=='NONSPECIFIC';

filter_group_desc_null  = filter filter_correct_type by  (group_desc IS NULL)  or (group_desc=='') or (SIZE(group_desc) <= 0 );

filter_group_desc_not_null = filter filter_correct_type by  (group_desc IS NOT NULL) or (group_desc!='') or (SIZE(group_desc) > 0 ) ;


populate_groupdesc_default = FOREACH filter_group_desc_null GENERATE 
affiliate_code as affiliate_code,
affiliate_desc as affiliate_desc,
type as type,
year as year,
'NONSPECIFIC' as group_desc,
usd_val_jan as usd_val_jan,
usd_val_feb as usd_val_feb,
usd_val_mar as usd_val_mar,
usd_val_apr as usd_val_apr,
usd_val_may as usd_val_may,
usd_val_jun as usd_val_jun,
usd_val_jul as usd_val_jul,
usd_val_aug as usd_val_aug,
usd_val_sep as usd_val_sep,
usd_val_oct as usd_val_oct,
usd_val_nov as usd_val_nov,
usd_val_dec as usd_val_dec,
upload_id as upload_id,
file_name as file_name,
usr_eml_id as usr_eml_id,
comment as comment,
created_by as created_by,
created_date as created_date;

join_topopulate_default_group_desc = join populate_groupdesc_default by group_desc, get_default_d56 by group_desc;

group_desc_pass_set1 = FOREACH join_topopulate_default_group_desc GENERATE 
populate_groupdesc_default::affiliate_code as affiliate_code,
populate_groupdesc_default::affiliate_desc as affiliate_desc,
populate_groupdesc_default::type as type,
populate_groupdesc_default::year as year,
populate_groupdesc_default::group_desc as group_desc,
populate_groupdesc_default::upload_id as upload_id,
populate_groupdesc_default::usd_val_jan as usd_val_jan,
populate_groupdesc_default::usd_val_feb as usd_val_feb,
populate_groupdesc_default::usd_val_mar as usd_val_mar,
populate_groupdesc_default::usd_val_apr as usd_val_apr,
populate_groupdesc_default::usd_val_may as usd_val_may,
populate_groupdesc_default::usd_val_jun as usd_val_jun,
populate_groupdesc_default::usd_val_jul as usd_val_jul,
populate_groupdesc_default::usd_val_aug as usd_val_aug,
populate_groupdesc_default::usd_val_sep as usd_val_sep,
populate_groupdesc_default::usd_val_oct as usd_val_oct,
populate_groupdesc_default::usd_val_nov as usd_val_nov,
populate_groupdesc_default::usd_val_dec as usd_val_dec,
populate_groupdesc_default::file_name as file_name,
populate_groupdesc_default::usr_eml_id as usr_eml_id,
populate_groupdesc_default::comment as comment,
populate_groupdesc_default::created_by as created_by,
populate_groupdesc_default::created_date as created_date,
get_default_d56::d56_item_no as d56_item_no;

join_tovalidate_group_desc = join filter_group_desc_not_null by group_desc LEFT OUTER, d56_item_no_group_desc by group_desc;

group_desc_fail_records = filter join_tovalidate_group_desc by  (d56_item_no_group_desc::group_desc IS NULL)  or (d56_item_no_group_desc::group_desc=='') or (SIZE(d56_item_no_group_desc::group_desc) <= 0 );
group_desc_pass_records = filter join_tovalidate_group_desc by  (d56_item_no_group_desc::group_desc IS NOT NULL)  or (d56_item_no_group_desc::group_desc!='') or (SIZE(d56_item_no_group_desc::group_desc) > 0 );

group_desc_validation_fail_records = FOREACH group_desc_fail_records GENERATE 
filter_group_desc_not_null::upload_id as upload_id,
filter_group_desc_not_null::affiliate_code as affiliate_code,
filter_group_desc_not_null::type as type,
filter_group_desc_not_null::year as year,
'$current_month' as month,
'NULL' as sap_material_no,
filter_group_desc_not_null::group_desc as group_desc,
filter_group_desc_not_null::file_name as file_name,
filter_group_desc_not_null::usr_eml_id as usr_eml_id,
filter_group_desc_not_null::created_date as created_date,
filter_group_desc_not_null::created_by as created_by;

load_failed_records(group_desc_validation_fail_records,'<UPD_GAP> - Uploaded data group desc failed');

group_desc_pass_set2 = FOREACH group_desc_pass_records GENERATE 
filter_group_desc_not_null::affiliate_code as affiliate_code,
filter_group_desc_not_null::affiliate_desc as affiliate_desc,
filter_group_desc_not_null::type as type,
filter_group_desc_not_null::year as year,
filter_group_desc_not_null::group_desc as group_desc,
filter_group_desc_not_null::upload_id as upload_id,
filter_group_desc_not_null::usd_val_jan as usd_val_jan,
filter_group_desc_not_null::usd_val_feb as usd_val_feb,
filter_group_desc_not_null::usd_val_mar as usd_val_mar,
filter_group_desc_not_null::usd_val_apr as usd_val_apr,
filter_group_desc_not_null::usd_val_may as usd_val_may,
filter_group_desc_not_null::usd_val_jun as usd_val_jun,
filter_group_desc_not_null::usd_val_jul as usd_val_jul,
filter_group_desc_not_null::usd_val_aug as usd_val_aug,
filter_group_desc_not_null::usd_val_sep as usd_val_sep,
filter_group_desc_not_null::usd_val_oct as usd_val_oct,
filter_group_desc_not_null::usd_val_nov as usd_val_nov,
filter_group_desc_not_null::usd_val_dec as usd_val_dec,
filter_group_desc_not_null::file_name as file_name,
filter_group_desc_not_null::usr_eml_id as usr_eml_id,
filter_group_desc_not_null::comment as comment,
filter_group_desc_not_null::created_by as created_by,
filter_group_desc_not_null::created_date as created_date,
d56_item_no_group_desc::d56_item_no as d56_item_no;

all_group_desc_records = union group_desc_pass_set1,group_desc_pass_set2;

get_sap_material_no = join all_group_desc_records by (d56_item_no,affiliate_code) LEFT OUTER, stg_item by (d56_item_no,loc);
sap_material_no_fail_records = filter get_sap_material_no by  (stg_item::item_code IS NULL) or (stg_item::item_code=='') or (SIZE(stg_item::item_code) <= 0 );
sap_material_no_pass_records = filter get_sap_material_no by  (stg_item::item_code IS NOT NULL)  or (stg_item::item_code!='') or (SIZE(stg_item::item_code) > 0 );


sap_material_no_validation_fail_records = FOREACH sap_material_no_fail_records GENERATE 
all_group_desc_records::upload_id as upload_id,
all_group_desc_records::affiliate_code as affiliate_code,
all_group_desc_records::type as type,
all_group_desc_records::year as year,
'$current_month' as month,
'' as sap_material_no,
all_group_desc_records::group_desc as group_desc,
all_group_desc_records::file_name as file_name,
all_group_desc_records::usr_eml_id as usr_eml_id,
all_group_desc_records::created_date as created_date,
all_group_desc_records::created_by as created_by;

load_failed_records(sap_material_no_validation_fail_records,'Failed in sap_material_no_validation_fail_records validation');

sap_material_no_validation_pass_records = FOREACH sap_material_no_pass_records GENERATE
all_group_desc_records::affiliate_code as affiliate_code,
all_group_desc_records::affiliate_desc as affiliate_desc,
all_group_desc_records::type as type,
all_group_desc_records::year as year,
stg_item::item_code as sap_material_no,
all_group_desc_records::group_desc as group_desc,
all_group_desc_records::d56_item_no as d56_item_no,
all_group_desc_records::upload_id as upload_id,
all_group_desc_records::usd_val_jan as usd_val_jan,
all_group_desc_records::usd_val_feb as usd_val_feb,
all_group_desc_records::usd_val_mar as usd_val_mar,
all_group_desc_records::usd_val_apr as usd_val_apr,
all_group_desc_records::usd_val_may as usd_val_may,
all_group_desc_records::usd_val_jun as usd_val_jun,
all_group_desc_records::usd_val_jul as usd_val_jul,
all_group_desc_records::usd_val_aug as usd_val_aug,
all_group_desc_records::usd_val_sep as usd_val_sep,
all_group_desc_records::usd_val_oct as usd_val_oct,
all_group_desc_records::usd_val_nov as usd_val_nov,
all_group_desc_records::usd_val_dec as usd_val_dec,
all_group_desc_records::file_name as file_name,
all_group_desc_records::usr_eml_id as usr_eml_id,
all_group_desc_records::comment as comment,
all_group_desc_records::created_by as created_by,
all_group_desc_records::created_date as created_date;
	
	
filter_primary_ind = FILTER stg_primary_plant_lookup by primary_ind=='x';
	
	
join_primary_plant = join sap_material_no_validation_pass_records by affiliate_code LEFT OUTER, filter_primary_ind by affiliate_code;
primary_plant_lookup_fail_records = filter join_primary_plant by  (filter_primary_ind::affiliate_code IS NULL) or (filter_primary_ind::affiliate_code=='') or (SIZE(filter_primary_ind::affiliate_code) <= 0 );
primary_plant_lookup_pass_records = filter join_primary_plant by  (filter_primary_ind::affiliate_code IS NOT NULL) or (filter_primary_ind::affiliate_code!='') or (SIZE(filter_primary_ind::affiliate_code) > 0 );

primary_plant_lookup_validation_fail_records = FOREACH primary_plant_lookup_fail_records GENERATE 
sap_material_no_validation_pass_records::upload_id as upload_id,
sap_material_no_validation_pass_records::affiliate_code as affiliate_code,
sap_material_no_validation_pass_records::type as type,
sap_material_no_validation_pass_records::year as year,
'$current_month' as month,
sap_material_no_validation_pass_records::sap_material_no as sap_material_no,
sap_material_no_validation_pass_records::group_desc as group_desc,
sap_material_no_validation_pass_records::file_name as file_name,
sap_material_no_validation_pass_records::usr_eml_id as usr_eml_id,
sap_material_no_validation_pass_records::created_date as created_date,
sap_material_no_validation_pass_records::created_by as created_by;

load_failed_records(primary_plant_lookup_validation_fail_records,'Failed in Primary Plant lookup validation');


get_plant_company_detail = FOREACH primary_plant_lookup_pass_records GENERATE 
sap_material_no_validation_pass_records::affiliate_code as affiliate_code,
sap_material_no_validation_pass_records::type as type,
sap_material_no_validation_pass_records::year as year,
sap_material_no_validation_pass_records::sap_material_no as sap_material_no,
sap_material_no_validation_pass_records::d56_item_no as d56_item_no,
sap_material_no_validation_pass_records::affiliate_desc as affiliate_desc,
(chararray)filter_primary_ind::company_code as company_code,
(chararray)filter_primary_ind::plant as plant_id,
sap_material_no_validation_pass_records::usr_eml_id as usr_eml_id,
sap_material_no_validation_pass_records::group_desc as group_desc,
'0' as standard_cost_usd,
'0' as standard_cost_lc,
'USD' as local_currency,
'0' as units_jan,
'0' as units_feb,
'0' as units_mar,
'0' as units_apr,
'0' as units_may,
'0' as units_jun,
'0' as units_jul,
'0' as units_aug,
'0' as units_sep,
'0' as units_oct,
'0' as units_nov,
'0' as units_dec,
'0' as local_val_jan,
'0' as local_val_feb,
'0' as local_val_mar,
'0' as local_val_apr,
'0' as local_val_may,
'0' as local_val_jun,
'0' as local_val_jul,
'0' as local_val_aug,
'0' as local_val_sep,
'0' as local_val_oct,
'0' as local_val_nov,
'0' as local_val_dec,
sap_material_no_validation_pass_records::usd_val_jan as usd_val_jan,
sap_material_no_validation_pass_records::usd_val_feb as usd_val_feb,
sap_material_no_validation_pass_records::usd_val_mar as usd_val_mar,
sap_material_no_validation_pass_records::usd_val_apr as usd_val_apr,
sap_material_no_validation_pass_records::usd_val_may as usd_val_may,
sap_material_no_validation_pass_records::usd_val_jun as usd_val_jun,
sap_material_no_validation_pass_records::usd_val_jul as usd_val_jul,
sap_material_no_validation_pass_records::usd_val_aug as usd_val_aug,
sap_material_no_validation_pass_records::usd_val_sep as usd_val_sep,
sap_material_no_validation_pass_records::usd_val_oct as usd_val_oct,
sap_material_no_validation_pass_records::usd_val_nov as usd_val_nov,
sap_material_no_validation_pass_records::usd_val_dec as usd_val_dec,
sap_material_no_validation_pass_records::upload_id as upload_id,
sap_material_no_validation_pass_records::comment as comment,
sap_material_no_validation_pass_records::file_name as file_name,
sap_material_no_validation_pass_records::created_by as created_by,
sap_material_no_validation_pass_records::created_date as created_date;


group_byuploadid =  GROUP get_plant_company_detail by (affiliate_code,type,year,d56_item_no,sap_material_no);

distinctItems  = FOREACH group_byuploadid {
    sorted =  ORDER get_plant_company_detail BY created_date,upload_id ASC;
    GENERATE FLATTEN(Enumerate(sorted)) as (affiliate_code,type,year,sap_material_no,d56_item_no,affiliate_desc,company_code,plant_id,usr_eml_id,group_desc,standard_cost_usd,standard_cost_lc,local_currency,units_jan,units_feb,units_mar,units_apr,units_may,units_jun,units_jul,units_aug,units_sep,units_oct,units_nov,units_dec,local_val_jan,local_val_feb,local_val_mar,local_val_apr,local_val_may,local_val_jun,local_val_jul,local_val_aug,local_val_sep,local_val_oct,local_val_nov,local_val_dec,usd_val_jan,usd_val_feb,usd_val_mar,usd_val_apr,usd_val_may,usd_val_jun,usd_val_jul,usd_val_aug,usd_val_sep,usd_val_oct,usd_val_nov,usd_val_dec,upload_id,comment,file_name,created_by,created_date,index);
};

upload_data_non_duplicate = FILTER distinctItems by index==1;
upload_data_duplicates = FILTER distinctItems by index>1;

store_uploaddata_dupe_validation_fail_records = FOREACH upload_data_duplicates GENERATE
upload_id as upload_id,
affiliate_code as affiliate_code,
type as type,
year as year,
'$current_month' as month,
sap_material_no as sap_material_no,
group_desc as group_desc,
file_name as file_name,
usr_eml_id as usr_eml_id,
created_date as created_date,
created_by as created_by;

load_failed_records(store_uploaddata_dupe_validation_fail_records,'<PLN_UPD> - Duplicate data in  uploaded files ');



find_duplicates = join upload_data_non_duplicate by (affiliate_code,type,year,sap_material_no,d56_item_no) LEFT OUTER, web_plan_upd_gap by (AFFILIATE_CODE,TYPE,YEAR,SAP_MATERIAL_NO,D56_ITEM_NO);

non_dupe_records =  filter find_duplicates by  (web_plan_upd_gap::AFFILIATE_CODE IS  NULL) and (web_plan_upd_gap::TYPE IS  NULL) and (web_plan_upd_gap::YEAR IS NULL) and  (web_plan_upd_gap::SAP_MATERIAL_NO IS  NULL) and (web_plan_upd_gap::D56_ITEM_NO IS  NULL);

dupe_records = filter find_duplicates by  (web_plan_upd_gap::AFFILIATE_CODE IS NOT NULL) and (web_plan_upd_gap::TYPE IS NOT NULL) and (web_plan_upd_gap::YEAR IS NOT NULL) and (web_plan_upd_gap::SAP_MATERIAL_NO IS  NULL)  and (web_plan_upd_gap::D56_ITEM_NO IS NOT NULL);


dupe_fail_records = FOREACH dupe_records GENERATE 
upload_data_non_duplicate::upload_id as upload_id,
upload_data_non_duplicate::affiliate_code as affiliate_code,
upload_data_non_duplicate::type as type,
upload_data_non_duplicate::year as year,
'$current_month' as month,
upload_data_non_duplicate::sap_material_no as sap_material_no,
upload_data_non_duplicate::group_desc as group_desc,
upload_data_non_duplicate::file_name as file_name,
upload_data_non_duplicate::usr_eml_id as usr_eml_id,
upload_data_non_duplicate::created_date as created_date,
upload_data_non_duplicate::created_by as created_by;


load_failed_records(dupe_fail_records,'<UPD_GAP> - Record already exists');


load_upd_gap_data = FOREACH non_dupe_records GENERATE 
upload_data_non_duplicate::affiliate_code as affiliate_code,
upload_data_non_duplicate::type as type,
upload_data_non_duplicate::year as year,
upload_data_non_duplicate::sap_material_no as  sap_material_no,
upload_data_non_duplicate::d56_item_no as d56_item_no,
upload_data_non_duplicate::affiliate_desc as affiliate_desc,
upload_data_non_duplicate::company_code as company_code,
upload_data_non_duplicate::plant_id as plant_id,
upload_data_non_duplicate::group_desc as group_desc,
upload_data_non_duplicate::standard_cost_usd as standard_cost_usd,
upload_data_non_duplicate::standard_cost_lc as standard_cost_lc,
upload_data_non_duplicate::local_currency as local_currency,
upload_data_non_duplicate::units_jan as units_jan,
upload_data_non_duplicate::units_feb as units_feb,
upload_data_non_duplicate::units_mar as units_mar,
upload_data_non_duplicate::units_apr as units_apr,
upload_data_non_duplicate::units_may as units_may,
upload_data_non_duplicate::units_jun as units_jun,
upload_data_non_duplicate::units_jul as units_jul,
upload_data_non_duplicate::units_aug as units_aug,
upload_data_non_duplicate::units_sep as units_sep,
upload_data_non_duplicate::units_oct as units_oct,
upload_data_non_duplicate::units_nov as units_nov,
upload_data_non_duplicate::units_dec as units_dec,
upload_data_non_duplicate::local_val_jan as local_val_jan,
upload_data_non_duplicate::local_val_feb as local_val_feb,
upload_data_non_duplicate::local_val_mar as local_val_mar,
upload_data_non_duplicate::local_val_apr as local_val_apr,
upload_data_non_duplicate::local_val_may as local_val_may,
upload_data_non_duplicate::local_val_jun as local_val_jun,
upload_data_non_duplicate::local_val_jul as local_val_jul,
upload_data_non_duplicate::local_val_aug as local_val_aug,
upload_data_non_duplicate::local_val_sep as local_val_sep,
upload_data_non_duplicate::local_val_oct as local_val_oct,
upload_data_non_duplicate::local_val_nov as local_val_nov,
upload_data_non_duplicate::local_val_dec as local_val_dec,
upload_data_non_duplicate::usd_val_jan as usd_val_jan,
upload_data_non_duplicate::usd_val_feb as usd_val_feb,
upload_data_non_duplicate::usd_val_mar as usd_val_mar,
upload_data_non_duplicate::usd_val_apr as usd_val_apr,
upload_data_non_duplicate::usd_val_may as usd_val_may,
upload_data_non_duplicate::usd_val_jun as usd_val_jun,
upload_data_non_duplicate::usd_val_jul as usd_val_jul,
upload_data_non_duplicate::usd_val_aug as usd_val_aug,
upload_data_non_duplicate::usd_val_sep as usd_val_sep,
upload_data_non_duplicate::usd_val_oct as usd_val_oct,
upload_data_non_duplicate::usd_val_nov as usd_val_nov,
upload_data_non_duplicate::usd_val_dec as usd_val_dec,
upload_data_non_duplicate::comment as comment,
upload_data_non_duplicate::created_by as created_by,
upload_data_non_duplicate::created_date as created_date,
'moscivisdev' as last_upd_by,
 ToString(CurrentTime(),'MM/dd/YYYY hh:mm:ss a') as last_upd_date;

STORE load_upd_gap_data INTO 'hbase://${PHOENIX_SCHEMA_ENV}.WEB_PLAN_UPD_GAP' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');

