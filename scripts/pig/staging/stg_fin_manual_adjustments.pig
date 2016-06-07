/*
####################################################
# File:   : stg_fin_manual_adjustments.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 28, 2016
# Author  : Bowen, Jared
# Comments: Load Financial Adjustments Table to Hive
#####################################################             
*/

REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

%declare CURR_DATE `date +%m/%d/%Y`;

A = LOAD 'hbase://table/${HBASE_DATABASE}.web_fin_manual_adjustments' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${HBASE_CONFIG}');

B = FOREACH A GENERATE 
AFFILIATE_CODE as affiliate_code,
TYPE as type,
MONTH as month,
YEAR as year,
MATERIAL_NO as material_no,
D56_ITEM_NO as d56_item_no,
AFFILIATE_DESC as affiliate_desc,
COMPANY_CODE as company_code,
PLANT_ID as plant_id,
GROUP_DESC as group_desc,
ADJUSTED_VALUE_USD as adjusted_value_usd,
COMMENT as comment,
CREATED_BY as created_by,
'$CURR_DATE' as created_date;

STORE B INTO '${DATABASE}.stg_fin_manual_adjustments' USING org.apache.hive.hcatalog.pig.HCatStorer();