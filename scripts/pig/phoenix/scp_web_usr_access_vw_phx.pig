SET mapreduce.fileoutputcommitter.marksuccessfuljobs false


REGISTER ${PHX_JAR_LOC};


scp_web_usr_access_vw = LOAD '${IVIS_HIVE_DATABASE}.SCP_WEB_USR_ACCESS_VW' USING org.apache.hive.hcatalog.pig.HCatLoader();
STORE scp_web_usr_access_vw INTO 'hbase://${PHOENIX_SCHEMA_ENV}.SCP_WEB_USR_ACCESS_VW' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');

