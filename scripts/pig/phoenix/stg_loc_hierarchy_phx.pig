SET mapreduce.fileoutputcommitter.marksuccessfuljobs false


REGISTER ${PHX_JAR_LOC};


stg_loc_hierarchy = LOAD '${IVIS_HIVE_DATABASE}.STG_LOC_HIERARCHY' USING org.apache.hive.hcatalog.pig.HCatLoader(); 
STORE stg_loc_hierarchy INTO 'hbase://${PHOENIX_SCHEMA_ENV}.STG_LOC_HIERARCHY' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 5000');
