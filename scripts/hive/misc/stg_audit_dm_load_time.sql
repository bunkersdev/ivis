USE ${DATABASE};


INSERT OVERWRITE TABLE STG_AUDIT_DM_LOAD_TIME
SELECT from_unixtime(unix_timestamp(concat('${YEAR}','${PERIOD}','01') ,'yyyyMMdd'), 'yyyy-MM-dd'),
        current_load_period,
       '${PROCESS_FLG}',
current_timestamp,
current_timestamp
FROM STG_AUDIT_DM_LOAD_TIME