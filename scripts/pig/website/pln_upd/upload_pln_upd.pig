/*
#################################################
# File:   : upload_plan_update.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Mar 15, 2015
# Author  : Selvakalathi,Kaviyarasan 
# Comments: Business uploaded plan update file is transformed and loaded to main  table web_plan_upd_gap                                        
 ##################################################                
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

/*
## Import the macros referred in the script 
*/

IMPORT '$LOAD_FAILURE_MACRO';
IMPORT '$PLN_UPD_USR_VALIDATION_MACRO';
REGISTER ${PHX_JAR_LOC};
REGISTER ${DATAFU_JAR_LOC};

define Enumerate datafu.pig.bags.Enumerate('1');


%declare Time `date +%Y-%m-%d`;
%declare current_month `date +%m`;
%declare current_year `date +%Y`;

/*
## Load the tables needed for read and write during transformation in pig script 
*/

upload_plan_upd = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.UPLOAD_PLAN_UPD' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');
web_plan_upd_gap = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.WEB_PLAN_UPD_GAP'  USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');
upload_process_summary = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.UPLOAD_PROCESS_SUMMARY' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');


stg_loc_hierarchy = LOAD '${IVIS_HIVE_DATABASE}.stg_loc_hierarchy' USING org.apache.hive.hcatalog.pig.HCatLoader();
stg_item = LOAD '${IVIS_HIVE_DATABASE}.stg_item' USING org.apache.hive.hcatalog.pig.HCatLoader();
exchange_rate_d = LOAD '${IVIS_HIVE_DATABASE}.exchange_rate_d' USING org.apache.hive.hcatalog.pig.HCatLoader(); 
sap_material_detail = LOAD '${IVIS_HIVE_DATABASE}.stg_sap_material_detail' USING org.apache.hive.hcatalog.pig.HCatLoader(); 
stg_d56_item_no =  LOAD '${IVIS_HIVE_DATABASE}.stg_d56_item_no' USING org.apache.hive.hcatalog.pig.HCatLoader(); 

filter_unprocessed = FILTER upload_process_summary by STATUS=='IN-PROCESS' and TYPE=='PLAN_UPD';

get_uploadrecords = join upload_plan_upd by UPLOAD_ID,filter_unprocessed by UPLOAD_ID  using 'replicated';;

get_dataset = FOREACH get_uploadrecords GENERATE 
TRIM(upload_plan_upd::AFFILIATE_CODE) as affiliate_code,
TRIM(upload_plan_upd::TYPE) as type,
TRIM(upload_plan_upd::YEAR) as year,
TRIM(upload_plan_upd::SAP_MATERIAL_NO) as sap_material_no,
TRIM(upload_plan_upd::UPLOAD_ID) as upload_id,
TRIM(upload_plan_upd::UNITS_JAN) as units_jan,
TRIM(upload_plan_upd::UNITS_FEB) as units_feb,
TRIM(upload_plan_upd::UNITS_MAR) as units_mar,
TRIM(upload_plan_upd::UNITS_APR) as units_apr,
TRIM(upload_plan_upd::UNITS_MAY) as units_may,
TRIM(upload_plan_upd::UNITS_JUN) as units_jun,
TRIM(upload_plan_upd::UNITS_JUL) as units_jul,
TRIM(upload_plan_upd::UNITS_AUG) as units_aug,
TRIM(upload_plan_upd::UNITS_SEP) as units_sep,
TRIM(upload_plan_upd::UNITS_OCT) as units_oct,
TRIM(upload_plan_upd::UNITS_NOV) as units_nov,
TRIM(upload_plan_upd::UNITS_DEC) as units_dec,
TRIM(upload_plan_upd::FILE_NAME) as file_name,
upload_plan_upd::COMMENT as comment,
TRIM(upload_plan_upd::CREATED_BY) as created_by,
TRIM(upload_plan_upd::CREATED_DATE) as created_date;

/*
##  Uploaded userid is validated against the tables for permission and access 
*/
user_validated_dataset = user_validation(get_dataset);

join_aff_code = join user_validated_dataset  by affiliate_code LEFT OUTER, stg_loc_hierarchy by level_10_code;

/*
##  Join the upload table with stg_loc table to get affiliate desc  
*/
aff_code_validation_failure = filter join_aff_code by  (stg_loc_hierarchy::level_10_code IS NULL) or (stg_loc_hierarchy::level_10_code=='') or (SIZE(stg_loc_hierarchy::level_10_code) <= 0);
aff_code_validation_success = filter join_aff_code by  (stg_loc_hierarchy::level_10_code IS NOT NULL) or (stg_loc_hierarchy::level_10_code!='') or (SIZE(stg_loc_hierarchy::level_10_code) > 0);	

store_aff_code_fail_records = FOREACH aff_code_validation_failure GENERATE
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::affiliate_code as affiliate_code,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
'$current_month' as month,
user_validated_dataset::sap_material_no as sap_material_no,
'NULL' as group_desc,
user_validated_dataset::file_name as file_name,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::created_date as created_date,
user_validated_dataset::created_by as created_by;

load_failed_records(store_aff_code_fail_records,'<PLN_UPD> - Affiliate Code in uploaded data is not valid ');

/*
##  Uploaded data validated for Current Year and  comment length less than equal to 100  
*/
filter_correct_year = filter aff_code_validation_success by user_validated_dataset::year == '$current_year';

filter_incorrect_year = filter aff_code_validation_success by user_validated_dataset::year != '$current_year';

store_year_validation_fail_records = FOREACH filter_incorrect_year GENERATE
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::affiliate_code as affiliate_code,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
'$current_month' as month,
user_validated_dataset::sap_material_no as sap_material_no,
'NULL' as group_desc,
user_validated_dataset::file_name as file_name,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::created_date as created_date,
user_validated_dataset::created_by as created_by;

load_failed_records(store_year_validation_fail_records,'<PLN_UPD> - Uploaded data does not have current year ');

filter_incorrect_comment_length = filter filter_correct_year by SIZE(user_validated_dataset::comment) > 100;

filter_correct_comment_length = filter filter_correct_year by (SIZE(user_validated_dataset::comment) <= 100 ) or (user_validated_dataset::comment IS NULL) or (user_validated_dataset::comment=='');

store_commentlength_validation_fail_records = FOREACH filter_incorrect_comment_length GENERATE
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::affiliate_code as affiliate_code,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
'$current_month' as month,
user_validated_dataset::sap_material_no as sap_material_no,
'NULL' as group_desc,
user_validated_dataset::file_name as file_name,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::created_date as created_date,
user_validated_dataset::created_by as created_by;

load_failed_records(store_commentlength_validation_fail_records,'<PLN_UPD> - Uploaded data comments greater than 100 character ');

store_commentlength_validation_passed_records = FOREACH filter_correct_comment_length GENERATE 
user_validated_dataset::affiliate_code as affiliate_code,
stg_loc_hierarchy::level_10_desc as affiliate_desc,
user_validated_dataset::type as type,
user_validated_dataset::year as year,
user_validated_dataset::sap_material_no as sap_material_no,
user_validated_dataset::upload_id as upload_id,
user_validated_dataset::units_jan as units_jan,
user_validated_dataset::units_feb as units_feb,
user_validated_dataset::units_mar as units_mar,
user_validated_dataset::units_apr as units_apr,
user_validated_dataset::units_may as units_may,
user_validated_dataset::units_jun as units_jun,
user_validated_dataset::units_jul as units_jul,
user_validated_dataset::units_aug as units_aug,
user_validated_dataset::units_sep as units_sep,
user_validated_dataset::units_oct as units_oct,
user_validated_dataset::units_nov as units_nov,
user_validated_dataset::units_dec as units_dec,
user_validated_dataset::usr_eml_id as usr_eml_id,
user_validated_dataset::file_name as file_name,
user_validated_dataset::comment as comment,
user_validated_dataset::created_by as created_by,
user_validated_dataset::created_date as created_date;

join_tovalidate_materialno = join store_commentlength_validation_passed_records by (sap_material_no,affiliate_code) LEFT OUTER, sap_material_detail by (material_no,jda_affiliate_code);

filter_incorrect_materialno = filter join_tovalidate_materialno  by (sap_material_detail::material_no IS NULL)  or (sap_material_detail::material_no=='') or (SIZE(sap_material_detail::material_no) <= 0) ;

filter_correct_materialno = filter join_tovalidate_materialno  by (sap_material_detail::material_no IS NOT NULL)  or (sap_material_detail::material_no!='') or (SIZE(sap_material_detail::material_no) > 0 ) ;

store_sapmaterialno_validation_passed_records = FOREACH filter_correct_materialno GENERATE 
store_commentlength_validation_passed_records::affiliate_code as affiliate_code,
store_commentlength_validation_passed_records::affiliate_desc as affiliate_desc,
store_commentlength_validation_passed_records::type as type,
store_commentlength_validation_passed_records::year as year,
store_commentlength_validation_passed_records::sap_material_no as sap_material_no,
store_commentlength_validation_passed_records::upload_id as upload_id,	
store_commentlength_validation_passed_records::units_jan as units_jan,
store_commentlength_validation_passed_records::units_feb as units_feb,
store_commentlength_validation_passed_records::units_mar as units_mar,
store_commentlength_validation_passed_records::units_apr as units_apr,
store_commentlength_validation_passed_records::units_may as units_may,
store_commentlength_validation_passed_records::units_jun as units_jun,
store_commentlength_validation_passed_records::units_jul as units_jul,
store_commentlength_validation_passed_records::units_aug as units_aug,
store_commentlength_validation_passed_records::units_sep as units_sep,
store_commentlength_validation_passed_records::units_oct as units_oct,
store_commentlength_validation_passed_records::units_nov as units_nov,
store_commentlength_validation_passed_records::units_dec as units_dec,
store_commentlength_validation_passed_records::usr_eml_id as usr_eml_id,
store_commentlength_validation_passed_records::file_name as file_name,
store_commentlength_validation_passed_records::comment as comment,
store_commentlength_validation_passed_records::created_by as created_by,
store_commentlength_validation_passed_records::created_date as created_date,
sap_material_detail::company_code as company_code,
sap_material_detail::d56_item_no as d56_item_no,
sap_material_detail::plant_id as plant_id,
sap_material_detail::standard_cost as standard_cost,
sap_material_detail::currency as currency;



store_sap_material_no_validation_fail_records = FOREACH filter_incorrect_materialno GENERATE
store_commentlength_validation_passed_records::upload_id as upload_id,
store_commentlength_validation_passed_records::affiliate_code as affiliate_code,
store_commentlength_validation_passed_records::type as type,
store_commentlength_validation_passed_records::year as year,
'$current_month' as month,
store_commentlength_validation_passed_records::sap_material_no as sap_material_no,
'NULL' as group_desc,
store_commentlength_validation_passed_records::file_name as file_name,
store_commentlength_validation_passed_records::usr_eml_id as usr_eml_id,
store_commentlength_validation_passed_records::created_date as created_date,
store_commentlength_validation_passed_records::created_by as created_by;

load_failed_records(store_sap_material_no_validation_fail_records,'<PLN_UPD> - Uploaded datas Material number not in Sap Material detail table ');


join_togetgroupdesc = join store_sapmaterialno_validation_passed_records by d56_item_no LEFT OUTER, stg_d56_item_no by d56_item_no;

filter_incorrect_d56_item_no = filter join_togetgroupdesc  by (stg_d56_item_no::d56_item_no IS NULL)  or (stg_d56_item_no::d56_item_no=='') or (SIZE(stg_d56_item_no::d56_item_no) <= 0) ;

store_d56_item_no_validation_fail_records = FOREACH filter_incorrect_d56_item_no GENERATE
store_sapmaterialno_validation_passed_records::upload_id as upload_id,
store_sapmaterialno_validation_passed_records::affiliate_code as affiliate_code,
store_sapmaterialno_validation_passed_records::type as type,
store_sapmaterialno_validation_passed_records::year as year,
'$current_month' as month,
store_sapmaterialno_validation_passed_records::sap_material_no as sap_material_no,
'NULL' as group_desc,
store_sapmaterialno_validation_passed_records::file_name as file_name,
store_sapmaterialno_validation_passed_records::usr_eml_id as usr_eml_id,
store_sapmaterialno_validation_passed_records::created_date as created_date,
store_sapmaterialno_validation_passed_records::created_by as created_by;

load_failed_records(store_d56_item_no_validation_fail_records,'<PLN_UPD> - Failed while fetching D56 item no joining d56 item no table ');

filter_correct_d56_item_no = filter join_togetgroupdesc  by (stg_d56_item_no::d56_item_no IS NOT NULL) or (stg_d56_item_no::d56_item_no!='') or (SIZE(stg_d56_item_no::d56_item_no) > 0 ) ;


get_groupdesc = FOREACH filter_correct_d56_item_no GENERATE 
store_sapmaterialno_validation_passed_records::affiliate_code as affiliate_code,
store_sapmaterialno_validation_passed_records::affiliate_desc as affiliate_desc,
store_sapmaterialno_validation_passed_records::type as type,
store_sapmaterialno_validation_passed_records::year as year,
store_sapmaterialno_validation_passed_records::sap_material_no as sap_material_no,
store_sapmaterialno_validation_passed_records::upload_id as upload_id,
store_sapmaterialno_validation_passed_records::units_jan as units_jan,
store_sapmaterialno_validation_passed_records::units_feb as units_feb,
store_sapmaterialno_validation_passed_records::units_mar as units_mar,
store_sapmaterialno_validation_passed_records::units_apr as units_apr,
store_sapmaterialno_validation_passed_records::units_may as units_may,
store_sapmaterialno_validation_passed_records::units_jun as units_jun,
store_sapmaterialno_validation_passed_records::units_jul as units_jul,
store_sapmaterialno_validation_passed_records::units_aug as units_aug,
store_sapmaterialno_validation_passed_records::units_sep as units_sep,
store_sapmaterialno_validation_passed_records::units_oct as units_oct,
store_sapmaterialno_validation_passed_records::units_nov as units_nov,
store_sapmaterialno_validation_passed_records::units_dec as units_dec,
store_sapmaterialno_validation_passed_records::file_name as file_name,
store_sapmaterialno_validation_passed_records::usr_eml_id as usr_eml_id,
store_sapmaterialno_validation_passed_records::comment as comment,
store_sapmaterialno_validation_passed_records::created_by as created_by,
store_sapmaterialno_validation_passed_records::created_date as created_date,
store_sapmaterialno_validation_passed_records::company_code as company_code,
store_sapmaterialno_validation_passed_records::d56_item_no as d56_item_no,
store_sapmaterialno_validation_passed_records::plant_id as plant_id,
store_sapmaterialno_validation_passed_records::standard_cost as standard_cost,
store_sapmaterialno_validation_passed_records::currency as local_currency,
stg_d56_item_no::groupdesc as group_desc;


filter_major_business = filter exchange_rate_d  by UPPER(major_business)=='PHARMA';

join_exchangerate = join get_groupdesc by (local_currency,CONCAT(CONCAT('$current_year','$current_month'),'01'),'USD') LEFT OUTER, filter_major_business by (conversion_from_code,(chararray)date_fk,conversion_to_code);

filter_incorrect_exchange_rate = filter join_exchangerate  by (filter_major_business::conversion_from_code IS NULL)  or (filter_major_business::conversion_from_code=='') or (SIZE(filter_major_business::conversion_from_code) <= 0 ) ; 

store_exchangerate_validation_fail_records = FOREACH filter_incorrect_exchange_rate GENERATE
get_groupdesc::upload_id as upload_id,
get_groupdesc::affiliate_code as affiliate_code,
get_groupdesc::type as type,
get_groupdesc::year as year,
'$current_month' as month,
get_groupdesc::sap_material_no as sap_material_no,
get_groupdesc::group_desc as group_desc,
get_groupdesc::file_name as file_name,
get_groupdesc::usr_eml_id as usr_eml_id,
get_groupdesc::created_date as created_date,
get_groupdesc::created_by as created_by;

load_failed_records(store_exchangerate_validation_fail_records,'<PLN_UPD> - Failed while fetching exchange_rates  joining exchange_rate table ');

filter_correct_exchange_rate = filter join_exchangerate  by (filter_major_business::conversion_from_code IS NOT NULL) or (filter_major_business::conversion_from_code!='') or (SIZE(filter_major_business::conversion_from_code) > 0) ; 

get_exhange_rate = FOREACH filter_correct_exchange_rate GENERATE 
get_groupdesc::affiliate_code as affiliate_code,
get_groupdesc::affiliate_desc as affiliate_desc,
get_groupdesc::type as type,
get_groupdesc::year as year,
get_groupdesc::sap_material_no as sap_material_no,
get_groupdesc::upload_id as upload_id,
(UPPER(get_groupdesc::type)=='PLAN'?get_groupdesc::units_jan:'0') as units_jan,
(UPPER(get_groupdesc::type)=='PLAN'?get_groupdesc::units_feb:'0') as units_feb,
(UPPER(get_groupdesc::type)=='PLAN'?get_groupdesc::units_mar:'0') as units_mar,
(UPPER(get_groupdesc::type)=='PLAN'?get_groupdesc::units_apr:'0') as units_apr,
(UPPER(get_groupdesc::type)=='PLAN'?get_groupdesc::units_may:'0') as units_may,
(UPPER(get_groupdesc::type)=='PLAN'?get_groupdesc::units_jun:'0') as units_jun,
get_groupdesc::units_jul as units_jul,
get_groupdesc::units_aug as units_aug,
get_groupdesc::units_sep as units_sep,
get_groupdesc::units_oct as units_oct,
get_groupdesc::units_nov as units_nov,
get_groupdesc::units_dec as units_dec,
get_groupdesc::file_name as file_name,
get_groupdesc::usr_eml_id as usr_eml_id,
get_groupdesc::comment as comment,
get_groupdesc::created_by as created_by,
get_groupdesc::created_date as created_date,
get_groupdesc::company_code as company_code,
get_groupdesc::d56_item_no as d56_item_no,
get_groupdesc::plant_id as plant_id,
get_groupdesc::standard_cost as standard_cost,
get_groupdesc::local_currency as currency,
get_groupdesc::group_desc as group_desc,
get_groupdesc::standard_cost as standard_cost_lc,
filter_major_business::conversion_from_code as conversion_from_code,
filter_major_business::plan_book_exchange_rate as exchange_rate;

group_byuploadid =  GROUP get_exhange_rate by (affiliate_code,type,year,d56_item_no,sap_material_no);

distinctItems  = FOREACH group_byuploadid {
    sorted =  ORDER get_exhange_rate BY created_date,upload_id ASC;
    GENERATE FLATTEN(Enumerate(sorted)) as (affiliate_code,affiliate_desc,type,year,sap_material_no,upload_id,units_jan,units_feb,units_mar,units_apr,units_may,units_jun,units_jul,units_aug,units_sep,units_oct,units_nov,units_dec,file_name,usr_eml_id,comment,created_by,created_date,company_code,d56_item_no,plant_id,standard_cost,currency,group_desc,standard_cost_lc,conversion_from_code,exchange_rate,index);
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

load_failed_records(store_uploaddata_dupe_validation_fail_records,'<PLN_UPD> - Duplicate data in  uploaded files');


find_duplicates = join upload_data_non_duplicate  by (affiliate_code,type,year,sap_material_no,d56_item_no) LEFT OUTER, web_plan_upd_gap by (AFFILIATE_CODE,TYPE,YEAR,SAP_MATERIAL_NO,D56_ITEM_NO);

non_dupe_records =  filter find_duplicates by  (web_plan_upd_gap::AFFILIATE_CODE IS  NULL) and (web_plan_upd_gap::TYPE IS  NULL) and (web_plan_upd_gap::YEAR IS NULL) and (web_plan_upd_gap::SAP_MATERIAL_NO IS  NULL) and (web_plan_upd_gap::GROUP_DESC IS  NULL);

dupe_records = filter find_duplicates by  (web_plan_upd_gap::AFFILIATE_CODE IS NOT NULL) and (web_plan_upd_gap::TYPE IS NOT NULL) and (web_plan_upd_gap::YEAR IS NOT NULL) and (web_plan_upd_gap::SAP_MATERIAL_NO IS NOT NULL) and (web_plan_upd_gap::GROUP_DESC IS NOT NULL);

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

load_failed_records(dupe_fail_records,'<PLN_UPD> - Record already Exists ');

preload_upd_pln_data = FOREACH non_dupe_records GENERATE 
upload_data_non_duplicate::affiliate_code as affiliate_code,
upload_data_non_duplicate::type as type,
upload_data_non_duplicate::year as year,
upload_data_non_duplicate::sap_material_no as  sap_material_no,
upload_data_non_duplicate::d56_item_no as d56_item_no,
upload_data_non_duplicate::affiliate_desc as affiliate_desc,
upload_data_non_duplicate::company_code as company_code,
(chararray)upload_data_non_duplicate::plant_id as plant_id,
upload_data_non_duplicate::group_desc as group_desc,
(chararray)(upload_data_non_duplicate::standard_cost * upload_data_non_duplicate::exchange_rate) as standard_cost_usd,
(chararray)upload_data_non_duplicate::standard_cost_lc as standard_cost_lc,
upload_data_non_duplicate::currency as local_currency,
upload_data_non_duplicate::upload_id as upload_id,
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
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_jan as local_val_jan,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_feb as local_val_feb,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_mar as local_val_mar,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_apr as local_val_apr,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_may as local_val_may,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_jun as local_val_jun,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_jul as local_val_jul,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_aug as local_val_aug,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_sep as local_val_sep,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_oct as local_val_oct,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_nov as local_val_nov,
upload_data_non_duplicate::standard_cost *  (double)upload_data_non_duplicate::units_dec as local_val_dec,
upload_data_non_duplicate::conversion_from_code as conversion_from_code,
upload_data_non_duplicate::exchange_rate as exchange_rate,
upload_data_non_duplicate::comment as comment,
upload_data_non_duplicate::created_by as created_by,
upload_data_non_duplicate::created_date as created_date;

load_upd_pln_data = FOREACH preload_upd_pln_data GENERATE 
affiliate_code,
type,
year,
sap_material_no,
d56_item_no,
affiliate_desc,
company_code,
plant_id,
group_desc,
standard_cost_usd,
standard_cost_lc,
local_currency,
units_jan,
units_feb,
units_mar,
units_apr,
units_may,
units_jun,
units_jul,
units_aug,
units_sep,
units_oct,
units_nov,
units_dec,
(chararray)local_val_jan,
(chararray)local_val_feb,
(chararray)local_val_mar,
(chararray)local_val_apr,
(chararray)local_val_may,
(chararray)local_val_jun,
(chararray)local_val_jul,
(chararray)local_val_aug,
(chararray)local_val_sep,
(chararray)local_val_oct,
(chararray)local_val_nov,
(chararray)local_val_dec,
(chararray)(conversion_from_code=='USD'?local_val_jan:local_val_jan * exchange_rate) as usd_val_jan,
(chararray)(conversion_from_code=='USD'?local_val_feb:local_val_feb * exchange_rate) as usd_val_feb,
(chararray)(conversion_from_code=='USD'?local_val_mar:local_val_mar * exchange_rate) as usd_val_mar,
(chararray)(conversion_from_code=='USD'?local_val_apr:local_val_apr * exchange_rate) as usd_val_apr,
(chararray)(conversion_from_code=='USD'?local_val_may:local_val_may * exchange_rate) as usd_val_may,
(chararray)(conversion_from_code=='USD'?local_val_jun:local_val_jun * exchange_rate) as usd_val_jun,
(chararray)(conversion_from_code=='USD'?local_val_jul:local_val_jul * exchange_rate) as usd_val_jul,
(chararray)(conversion_from_code=='USD'?local_val_aug:local_val_aug * exchange_rate) as usd_val_aug,
(chararray)(conversion_from_code=='USD'?local_val_sep:local_val_sep * exchange_rate) as usd_val_sep,
(chararray)(conversion_from_code=='USD'?local_val_oct:local_val_oct * exchange_rate) as usd_val_oct,
(chararray)(conversion_from_code=='USD'?local_val_nov:local_val_nov * exchange_rate) as usd_val_nov,
(chararray)(conversion_from_code=='USD'?local_val_dec:local_val_dec * exchange_rate) as usd_val_dec,
comment,
created_by,
created_date,
'moscivisdev' as last_upd_by,
 ToString(CurrentTime(),'MM/dd/YYYY hh:mm:ss a') as last_upd_date;


STORE load_upd_pln_data INTO 'hbase://${PHOENIX_SCHEMA_ENV}.WEB_PLAN_UPD_GAP' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');

