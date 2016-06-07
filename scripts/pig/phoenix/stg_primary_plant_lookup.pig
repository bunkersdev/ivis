/*
####################################################
# File:   : stg_primary_plant_lookup.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 28, 2016
# Author  : Bowen, Jared
# Comments: Load Primary Plant Lookup Table to HBase
#####################################################             
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

%declare CURR_DATE `date +%m/%d/%Y' '%r`;

A = LOAD '${DATABASE}.stg_primary_plant_lookup' USING org.apache.hive.hcatalog.pig.HCatLoader();

B = FOREACH A GENERATE 
plant,
name,
affiliate_code,
valuation_area,
sales_org,
company_code,
display_name,
primary_ind,
group_num,
'$CURR_DATE' as insert_dt,
created_by;

STORE B INTO 'hbase://${HBASE_DATABASE}.stg_primary_plant_lookup' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${HBASE_CONFIG}','-batchSize 3000');