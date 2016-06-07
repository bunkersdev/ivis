/*
####################################################
# File:   : stg_sap_plant_company_master.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 28, 2016
# Author  : Bowen, Jared
# Comments: Load Plant Company Master Table to HBase
#####################################################             
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

%declare CURR_DATE `date +%m/%d/%Y' '%r`;

A = LOAD '${DATABASE}.stg_sap_plant_company_master' USING org.apache.hive.hcatalog.pig.HCatLoader();

B = FOREACH A GENERATE
plant_id,
name,
valuation_area,
company_code,
plant_cust,
plant_vendor,
aff_code,
warehouse,                                                   
currency,
'$CURR_DATE' as insert_dt,
created_by;

STORE B INTO 'hbase://${HBASE_DATABASE}.stg_sap_plant_company_master' USING org.apache.phoenix.pig.PhoenixHBaseStorage('${HBASE_CONFIG}','-batchSize 3000');