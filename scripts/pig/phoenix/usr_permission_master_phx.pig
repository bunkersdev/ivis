SET mapreduce.fileoutputcommitter.marksuccessfuljobs false


REGISTER ${PHX_JAR_LOC};


usr_permission_master = LOAD '${IVIS_HIVE_DATABASE}.USR_PERMISSION_MASTER' USING org.apache.hive.hcatalog.pig.HCatLoader();
STORE usr_permission_master INTO 'hbase://${PHOENIX_SCHEMA_ENV}.USR_PERMISSION_MASTER' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');
