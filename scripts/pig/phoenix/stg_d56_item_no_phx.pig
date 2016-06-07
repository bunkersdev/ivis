SET mapreduce.fileoutputcommitter.marksuccessfuljobs false


REGISTER ${PHX_JAR_LOC};

stg_d56_item_no = LOAD '${IVIS_HIVE_DATABASE}.STG_D56_ITEM_NO' USING org.apache.hive.hcatalog.pig.HCatLoader();
STORE stg_d56_item_no INTO 'hbase://${PHOENIX_SCHEMA_ENV}.STG_D56_ITEM_NO' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');

