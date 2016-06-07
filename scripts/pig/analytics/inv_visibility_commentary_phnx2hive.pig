/*
####################################################
# File:   : inv_visibility_commentary_phnx2hive.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 20, 2015
# Author  : Sharma, Shubhankar
# Comments: Load Commentary Table to Hive
####################################################                
*/


--REGISTER /home/moscdev/phoenix/jars/phoenix-1.2.0-client.jar;
REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

inv_vis_commentary_phnx = LOAD 'hbase://table/${HBASE_DATABASE}.INV_VISIBILITY_COMMENTARY_F' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${HBASE_CONFIG}');
inv_vis_commentary = FILTER inv_vis_commentary_phnx BY DELETE_FLAG == 'N' and YEAR == ${YEAR} and PERIOD == ${PERIOD};
--DUMP inv_vis_commentary;

case_correction = FOREACH inv_vis_commentary GENERATE
AFFILIATE_CODE as affiliate_code,
GROUP_DESC as group_desc,
AFFILIATE_DESC as affiliate_desc,
PLANT_ID as plant_id,
COMPANY_CODE as company_code,
ACTUAL_BOH_ACT_BK_USD as actual_boh_act_bk_usd,
ACTUAL_BOH_PLN_BK_USD as actual_boh_pln_bk_usd,
ACTUAL_BOH_UPD_BK_USD as actual_boh_upd_bk_usd,
NET_BOH_PLN_USD as net_boh_pln_usd,
NET_BOH_ACT_USD as net_boh_act_usd,
PLAN_BOH_GROSS as plan_boh_gross,
ACTUAL_BOH_PLN_BK_VARNC_USD as actual_boh_pln_bk_varnc_usd,
NET_BOH_PLN_BK_VARNC_USD as net_boh_pln_bk_varnc_usd,
REASON_CODE as reason_code,
REASON_DESC as reason_desc,
COMMENTARY as commentary,
CREATED_BY as created_by ,
CREATED_DATE as created_date ,
LAST_UPD_BY as last_upd_by ,
LAST_UPD_DATE as last_upd_date ,
YEAR as year,
CASE SIZE(PERIOD)
WHEN 1
THEN CONCAT('0', (chararray)PERIOD)
ELSE (chararray)PERIOD
END as period;

--DUMP case_correction;

STORE case_correction  into '${DATABASE}.inv_visibility_commentary_f' using org.apache.hive.hcatalog.pig.HCatStorer();
