/*
####################################################
# File:   : stg_sap_material_detail.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 28, 2016
# Author  : Bowen, Jared
# Comments: Load Material Detail Table to HBase
#####################################################             
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false;

REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

%declare CURR_DATE `date +%m/%d/%Y' '%r`;

A = LOAD '${DATABASE}.stg_sap_material_detail' USING org.apache.hive.hcatalog.pig.HCatLoader();

B = FOREACH A GENERATE 
material_no,
d56_item_no,
sap_d56_item_no,
company_code,
plant_id,
supply_plant_id,
supply_plant_company_code,
jda_affiliate_code,
material_description,
material_type,
standard_cost,
currency,
base_uom,
'$CURR_DATE' as insert_dt,
created_by;

C = FILTER B BY plant_id IS NOT NULL;

STORE C INTO 'hbase://${HBASE_DATABASE}.stg_sap_material_detail' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${HBASE_CONFIG}','-batchSize 5000');