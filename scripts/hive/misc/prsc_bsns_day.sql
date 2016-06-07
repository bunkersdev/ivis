INSERT OVERWRITE DIRECTORY '${WF_DATA_DIR}/ivis/temp/ivis_prsc_day/'

SELECT CONCAT_WS('|','Y',cast(BSNS_DAY_NUM as string)) FROM ${DATABASE}.PRCS_BSNS_DAY_CAL WHERE from_unixtime(unix_timestamp(calendar_dt ,'yyyy-MM-dd'), 'yyyy-MM-dd') = CURRENT_DATE