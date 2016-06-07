use ${DATABASE};

INSERT OVERWRITE DIRECTORY '${WF_DATA_DIR}/ivis/temp/ivis_inv_varnc_email_lst/' 
SELECT distinct concat_ws('|',T1.AFFILIATE_CODE,
       T1.GROUP_DESC,
       cast(cast(ACTUAL_BOH_PLN_BK_VARNC_USD as decimal(25,10)) as string),
       cast(cast(NET_BOH_PLN_BK_VARNC_USD as decimal(25,10)) as string),
       SC_Email_to_grp,
       SC_Email_bcc_grp,
       Email_default_grp,
       cast(T1.YEAR as string),
       cast(T1.PERIOD as string) )
FROM INV_VISIBILITY_VARNC_F T1 ,
     IVIS_AFF_EMAIL_GRP T2
WHERE T1.AFFILIATE_CODE= T2.AFFILIATE_CODE
  AND T1.YEAR =${YEAR}
  AND T1.PERIOD=${PERIOD}
  AND ABS(ACTUAL_BOH_PLN_BK_VARNC_USD) > ${VARIANCE_THRESHOLD}