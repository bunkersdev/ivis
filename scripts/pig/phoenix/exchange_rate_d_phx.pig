SET mapreduce.fileoutputcommitter.marksuccessfuljobs false

REGISTER ${PHX_JAR_LOC};


exchange_rate_d = LOAD '${IVIS_HIVE_DATABASE}.EXCHANGE_RATE_D' USING org.apache.hive.hcatalog.pig.HCatLoader();

filter_to_code = FILTER exchange_rate_d by conversion_to_code=='USD';

STORE filter_to_code INTO 'hbase://${PHOENIX_SCHEMA_ENV}.EXCHANGE_RATE_D' USING  org.apache.phoenix.pig.PhoenixHBaseStorage('${PHOENIX_HBASE_CLUSTER}','-batchSize 3000');


