CREATE  TABLE IF NOT EXISTS [[APP_HBASE_DB_NAME]].UPLOAD_FAILURE_DETAILS(
upload_id          varchar,
affiliate_code     varchar,
type               varchar,
year               varchar,
month              varchar,
sap_material_no    varchar,
group_desc         varchar,
file_name          varchar,
usr_eml_id         varchar,
error_message      varchar,
created_date       varchar,
created_by       varchar,
delete_flag      varchar,
CONSTRAINT pk PRIMARY KEY (upload_id,affiliate_code,type,year,month,sap_material_no,group_desc) ) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';


CREATE  TABLE IF NOT EXISTS [[APP_HBASE_DB_NAME]].UPLOAD_PROCESS_SUMMARY(
upload_id         varchar,
type              varchar,
status            varchar,
file_name         varchar,
start_time        varchar,
end_time          varchar,
records_uploaded  varchar,
records_pass      varchar,
records_fail      varchar,
usr_eml_id        varchar,
created_date      varchar,
created_by        varchar,
CONSTRAINT pk PRIMARY KEY (upload_id) ) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';

