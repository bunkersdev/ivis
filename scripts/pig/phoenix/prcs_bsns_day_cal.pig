SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

REGISTER ${PHX_JAR_LOC};


prcs_bsns_day_cal = LOAD '${IVIS_HIVE_DATABASE}.PRCS_BSNS_DAY_CAL' USING org.apache.hive.hcatalog.pig.HCatLoader();
STORE prcs_bsns_day_cal INTO 'hbase://${PHOENIX_SCHEMA_ENV}.PRCS_BSNS_DAY_CAL' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');
