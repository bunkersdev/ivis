/*
####################################################
# File:   : stg_plan_upd_gap.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 28, 2016
# Author  : Bowen, Jared
# Comments: Load Plan Update Gap Table to Hive
#####################################################             
*/

REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

%declare CURR_DATE `date +%m/%d/%Y`;

A = LOAD 'hbase://table/${HBASE_DATABASE}.web_plan_upd_gap' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${HBASE_CONFIG}');

B = FOREACH A GENERATE 
AFFILIATE_CODE as affiliate_code,
TYPE as type,
YEAR as year,
SAP_MATERIAL_NO as sap_material_no,
D56_ITEM_NO as d56_item_no,
AFFILIATE_DESC as affiliate_desc,
COMPANY_CODE as company_code,
PLANT_ID as plant_id,
GROUP_DESC as group_desc,
STANDARD_COST_USD as standard_cost_usd,
STANDARD_COST_LC as standard_cost_lc,
LOCAL_CURRENCY as local_currency,
UNITS_JAN as units_jan,
UNITS_FEB as units_feb,
UNITS_MAR as units_mar,
UNITS_APR as units_apr,
UNITS_MAY as units_may,
UNITS_JUN as units_jun,
UNITS_JUL as units_jul,
UNITS_AUG as units_aug,
UNITS_SEP as units_sep,
UNITS_OCT as units_oct,
UNITS_NOV as units_nov,
UNITS_DEC as units_dec,
LOCAL_VAL_JAN as local_val_jan,
LOCAL_VAL_FEB as local_val_feb,
LOCAL_VAL_MAR as local_val_mar,
LOCAL_VAL_APR as local_val_apr,
LOCAL_VAL_MAY as local_val_may,
LOCAL_VAL_JUN as local_val_jun,
LOCAL_VAL_JUL as local_val_jul,
LOCAL_VAL_AUG as local_val_aug,
LOCAL_VAL_SEP as local_val_sep,
LOCAL_VAL_OCT as local_val_oct,
LOCAL_VAL_NOV as local_val_nov,
LOCAL_VAL_DEC as local_val_dec,
USD_VAL_JAN as usd_val_jan,
USD_VAL_FEB as usd_val_feb,
USD_VAL_MAR as usd_val_mar,
USD_VAL_APR as usd_val_apr,
USD_VAL_MAY as usd_val_may,
USD_VAL_JUN as usd_val_jun,
USD_VAL_JUL as usd_val_jul,
USD_VAL_AUG as usd_val_aug,
USD_VAL_SEP as usd_val_sep,
USD_VAL_OCT as usd_val_oct,
USD_VAL_NOV as usd_val_nov,
USD_VAL_DEC as usd_val_dec,
COMMENT as comment,
CREATED_BY as created_by, 
'$CURR_DATE' as created_date;

STORE B INTO '${DATABASE}.stg_plan_upd_gap' USING org.apache.hive.hcatalog.pig.HCatStorer();