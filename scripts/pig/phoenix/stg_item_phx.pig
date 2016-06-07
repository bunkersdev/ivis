SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

REGISTER ${PHX_JAR_LOC};


stg_item = LOAD '${IVIS_HIVE_DATABASE}.STG_ITEM' USING org.apache.hive.hcatalog.pig.HCatLoader();
STORE stg_item INTO 'hbase://${PHOENIX_SCHEMA_ENV}.STG_ITEM' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 1000');

