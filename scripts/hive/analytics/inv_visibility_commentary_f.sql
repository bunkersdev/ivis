USE ${DATABASE};
INSERT OVERWRITE TABLE INV_VISIBILITY_COMMENTARY_F partition (
  year = ${YEAR} , 
  period = ${PERIOD}
  )
SELECT AFFILIATE_CODE ,
       GROUP_DESC ,
       AFFILIATE_DESC ,
       PLANT_ID,
       COMPANY_CODE,
       ACTUAL_BOH_ACT_BK_USD ,
       ACTUAL_BOH_PLN_BK_USD ,
       ACTUAL_BOH_UPD_BK_USD ,
       NET_BOH_PLN_USD ,
       NET_BOH_ACT_USD ,
       PLAN_BOH_GROSS,
       ACTUAL_BOH_PLN_BK_VARNC_USD,
       NET_BOH_PLN_BK_VARNC_USD ,
       NULL AS REASON_CODE ,
               NULL AS REASON_DESC ,
                       NULL AS COMMENTARY ,
                               '${USER_NAME}' AS created_by,
                               CURRENT_DATE AS created_date,
                                               '${USER_NAME}' AS last_upd_by,
                                               CURRENT_DATE AS last_upd_date
FROM INV_VISIBILITY_VARNC_F INV_VARNC
WHERE ABS(ACTUAL_BOH_PLN_BK_VARNC_USD) > ${VARIANCE_THRESHOLD}
AND   year = ${YEAR}   and
  period = ${PERIOD}