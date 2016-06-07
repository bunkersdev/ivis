/*
#################################################
# File:   : upload_summary_status_inprocess.pig 
# Script  : 0 
# Version : 1.0.0 
# Date    : Mar 15, 2015
# Author  : Selvakalathi,Kaviyarasan 
# Comments: Business uploaded plan update file is tranformted and loaded to main   tableweb                                                                                                                        ##################################################                
*/

SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

REGISTER ${PHX_JAR_LOC};

%declare Time `date +%Y-%m-%d`;	
	
upload_plan_upd_gap = LOAD 'hbase://table/${PHOENIX_SCHEMA_ENV}.UPLOAD_PROCESS_SUMMARY' USING org.apache.phoenix.pig.PhoenixHBaseLoader('${PHOENIX_HBASE_CLUSTER}');

filter_bystatus = FILTER upload_plan_upd_gap by STATUS=='UPLOADED' and TYPE=='${TYPE}';

change_status = FOREACH filter_bystatus GENERATE
UPLOAD_ID,
TYPE,
'IN-PROCESS' as STATUS,
FILE_NAME ,
'$Time' as START_TIME,
END_TIME,
RECORDS_UPLOADED,
RECORDS_PASS,
RECORDS_FAIL,
USR_EML_ID,
CREATED_DATE,
CREATED_BY;

STORE change_status INTO 'hbase://${PHOENIX_SCHEMA_ENV}.UPLOAD_PROCESS_SUMMARY' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');
