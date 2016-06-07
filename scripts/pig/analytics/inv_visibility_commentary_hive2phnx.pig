/*
####################################################
# File:   : inv_visibility_commentary_hive2phnx.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Apr 20, 2015
# Author  : Sharma, Shubhankar
# Comments: Load Commentary Table to Phoenix
####################################################       
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false;

--REGISTER ${PHX_JAR_LOC};
REGISTER ${nameNode}${WF_APP_DIR}/jars/phoenix-1.2.0-client.jar;

--REGISTER /home/moscdev/phoenix/jars/phoenix-1.2.0-client.jar;
/*
## Load the tables needed for read and write during transformation in pig script 
*/
ivis_varnc_hive =  LOAD '${DATABASE}.inv_visibility_varnc_f' USING org.apache.hive.hcatalog.pig.HCatLoader();

ivis_varnc_threshold_hive = FILTER ivis_varnc_hive BY ABS(actual_boh_pln_bk_varnc_usd) > ${VARIANCE_THRESHOLD} AND (chararray)year == (chararray)${YEAR} AND (chararray)period == (chararray)${MONTH};

%declare CURR_DATE `date +%m/%d/%Y' '%r`;

ivis_commentary_phnx_data = LOAD 'hbase://table/${HBASE_DATABASE}.INV_VISIBILITY_COMMENTARY_F' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${HBASE_CONFIG}');

ivis_commentary_phnx = FILTER ivis_commentary_phnx_data BY YEAR == ${YEAR} AND PERIOD == ${MONTH};



--Insert into Hbase
commentaryLeftOuter = join ivis_varnc_threshold_hive by (affiliate_code,period,year,group_desc) LEFT OUTER, ivis_commentary_phnx by (AFFILIATE_CODE,PERIOD,YEAR,GROUP_DESC);

commentaryINS = FILTER commentaryLeftOuter BY ivis_commentary_phnx::AFFILIATE_CODE IS NULL AND ivis_commentary_phnx::PERIOD IS NULL AND
ivis_commentary_phnx::YEAR IS NULL AND 
ivis_commentary_phnx::GROUP_DESC IS NULL ;

insert_records = FOREACH commentaryINS GENERATE
ivis_varnc_threshold_hive::affiliate_code as affiliate_code,
ivis_varnc_threshold_hive::group_desc as GROUP_DESC,
ivis_varnc_threshold_hive::affiliate_desc as AFFILIATE_DESC,
ivis_varnc_threshold_hive::plant_id as PLANT_ID,
ivis_varnc_threshold_hive::company_code as COMPANY_CODE,
ivis_varnc_threshold_hive::actual_boh_act_bk_usd as ACTUAL_BOH_ACT_BK_USD,
ivis_varnc_threshold_hive::actual_boh_pln_bk_usd as ACTUAL_BOH_PLN_BK_USD,
ivis_varnc_threshold_hive::actual_boh_upd_bk_usd as ACTUAL_BOH_UPD_BK_USD,
ivis_varnc_threshold_hive::net_boh_pln_usd as NET_BOH_PLN_USD,
ivis_varnc_threshold_hive::net_boh_act_usd as NET_BOH_ACT_USD,
ivis_varnc_threshold_hive::plan_boh_gross as PLAN_BOH_GROSS,
ivis_varnc_threshold_hive::actual_boh_pln_bk_varnc_usd as ACTUAL_BOH_PLN_BK_VARNC_USD,
ivis_varnc_threshold_hive::net_boh_pln_bk_varnc_usd as NET_BOH_PLN_BK_VARNC_USD,
NULL as REASON_CODE,
NULL as REASON_DESC,
NULL as COMMENTARY,
'HIVE_USER' as CREATED_BY,
'$CURR_DATE' as CREATED_DATE,
'HIVE_USER' as LAST_UPD_BY,
'$CURR_DATE' as LAST_UPD_DATE,
ivis_varnc_threshold_hive::period as PERIOD,
ivis_varnc_threshold_hive::year as YEAR,
'N' as DELETE_FLAG;


--DUMP commentaryINS;
STORE insert_records INTO 'hbase://${HBASE_DATABASE}.INV_VISIBILITY_COMMENTARY_F' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${HBASE_CONFIG}','-batchSize 5000');



--Update in Hbase
commentaryJoin = join ivis_varnc_threshold_hive by (affiliate_code,period,year,group_desc) , ivis_commentary_phnx by (AFFILIATE_CODE,PERIOD,YEAR,GROUP_DESC);

update_records = FOREACH commentaryJoin GENERATE
ivis_varnc_threshold_hive::affiliate_code as affiliate_code,
ivis_varnc_threshold_hive::group_desc as GROUP_DESC,
ivis_varnc_threshold_hive::affiliate_desc as AFFILIATE_DESC,
ivis_varnc_threshold_hive::plant_id as PLANT_ID,
ivis_varnc_threshold_hive::company_code as COMPANY_CODE,
ivis_varnc_threshold_hive::actual_boh_act_bk_usd as ACTUAL_BOH_ACT_BK_USD,
ivis_varnc_threshold_hive::actual_boh_pln_bk_usd as ACTUAL_BOH_PLN_BK_USD,
ivis_varnc_threshold_hive::actual_boh_upd_bk_usd as ACTUAL_BOH_UPD_BK_USD,
ivis_varnc_threshold_hive::net_boh_pln_usd as NET_BOH_PLN_USD,
ivis_varnc_threshold_hive::net_boh_act_usd as NET_BOH_ACT_USD,
ivis_varnc_threshold_hive::plan_boh_gross as PLAN_BOH_GROSS,
ivis_varnc_threshold_hive::actual_boh_pln_bk_varnc_usd as ACTUAL_BOH_PLN_BK_VARNC_USD,
ivis_varnc_threshold_hive::net_boh_pln_bk_varnc_usd as NET_BOH_PLN_BK_VARNC_USD,
ivis_commentary_phnx::REASON_CODE as REASON_CODE,
ivis_commentary_phnx::REASON_DESC as REASON_DESC,
ivis_commentary_phnx::COMMENTARY as COMMENTARY,
'HIVE_USER' as CREATED_BY,
'$CURR_DATE' as CREATED_DATE,
'HIVE_USER' as LAST_UPD_BY,
'$CURR_DATE' as LAST_UPD_DATE,
ivis_varnc_threshold_hive::period as PERIOD,
ivis_varnc_threshold_hive::year as YEAR,
'N' as DELETE_FLAG;

STORE update_records INTO 'hbase://${HBASE_DATABASE}.INV_VISIBILITY_COMMENTARY_F' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${HBASE_CONFIG}','-batchSize 5000');



--Delete from Hbase
commentaryRightOuter = join ivis_varnc_threshold_hive by (affiliate_code,period,year,group_desc) RIGHT OUTER, ivis_commentary_phnx by (AFFILIATE_CODE,PERIOD,YEAR,GROUP_DESC);

commentaryDEL = FILTER commentaryRightOuter BY ivis_varnc_threshold_hive::affiliate_code IS NULL AND ivis_varnc_threshold_hive::period IS NULL AND 
ivis_varnc_threshold_hive::year IS NULL AND 
ivis_varnc_threshold_hive::group_desc IS NULL;


delete_records = FOREACH commentaryDEL GENERATE
ivis_commentary_phnx::AFFILIATE_CODE as AFFILIATE_CODE,
ivis_commentary_phnx::GROUP_DESC as GROUP_DESC,
ivis_commentary_phnx::AFFILIATE_DESC as AFFILIATE_DESC,
ivis_commentary_phnx::PLANT_ID as PLANT_ID,
ivis_commentary_phnx::COMPANY_CODE as COMPANY_CODE,
ivis_commentary_phnx::ACTUAL_BOH_ACT_BK_USD as ACTUAL_BOH_ACT_BK_USD,
ivis_commentary_phnx::ACTUAL_BOH_PLN_BK_USD as ACTUAL_BOH_PLN_BK_USD,
ivis_commentary_phnx::ACTUAL_BOH_UPD_BK_USD as ACTUAL_BOH_UPD_BK_USD,
ivis_commentary_phnx::NET_BOH_PLN_USD as NET_BOH_PLN_USD,
ivis_commentary_phnx::NET_BOH_ACT_USD as NET_BOH_ACT_USD,
ivis_varnc_threshold_hive::plan_boh_gross as PLAN_BOH_GROSS,
ivis_commentary_phnx::ACTUAL_BOH_PLN_BK_VARNC_USD as ACTUAL_BOH_PLN_BK_VARNC_USD,
ivis_commentary_phnx::NET_BOH_PLN_BK_VARNC_USD as NET_BOH_PLN_BK_VARNC_USD,
ivis_commentary_phnx::REASON_CODE as REASON_CODE,
ivis_commentary_phnx::REASON_DESC as REASON_DESC,
ivis_commentary_phnx::COMMENTARY as COMMENTARY,
'HIVE_USER' as CREATED_BY,
'$CURR_DATE' as CREATED_DATE,
'HIVE_USER' as LAST_UPD_BY,
'$CURR_DATE' as LAST_UPD_DATE,
ivis_commentary_phnx::PERIOD as PERIOD,
ivis_commentary_phnx::YEAR as YEAR,
'Y' as DELETE_FLAG;

--DUMP delete_records;

--Delete from Hbase
STORE delete_records INTO 'hbase://${HBASE_DATABASE}.INV_VISIBILITY_COMMENTARY_F' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${HBASE_CONFIG}','-batchSize 5000');
