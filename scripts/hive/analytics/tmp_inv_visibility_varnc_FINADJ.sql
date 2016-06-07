USE ${DATABASE};


INSERT overwrite TABLE tmp_inv_visibility partition(TYPE='FIN_ADJUST',YEAR=${YEAR},MONTH=${PERIOD})
SELECT FIN_ADJ.AFFILIATE_CODE,
       FIN_ADJ.GROUP_DESC AS GROUP_DESC,
       FIN_ADJ.AFFILIATE_DESC AS AFFILIATE_DESC,
       NULL AS PLANT_ID,
               NULL AS COMPANY_CODE,
                       SUM(NVL(FIN_ADJ.ACTUAL_BOH_ACT_BK_USD,0)) AS ACTUAL_BOH_ACT_BK_USD,
                       SUM(NVL(FIN_ADJ.ACTUAL_BOH_PLN_BK_USD,0)) AS ACTUAL_BOH_PLN_BK_USD,
                       SUM(NVL(FIN_ADJ.ACTUAL_BOH_UPD_BK_USD,0)) AS ACTUAL_BOH_UPD_BK_USD,
                       SUM(NVL(FIN_ADJ.NET_TCGM_VALUE_USD,0)) AS NET_TCGM_VALUE_USD
FROM
  (SELECT AFFILIATE_CODE AS AFFILIATE_CODE,
           stg_d56.GROUPDESC AS GROUP_DESC,
           stg_loc.LOC_DESC AS AFFILIATE_DESC,
           NULL AS PLANT_ID,
                   NULL AS COMPANY_CODE,
                           CASE
                               WHEN upper(INVENTORY_TYPE) LIKE 'RESERVE%' THEN NVL(SUM(ACTUAL_VALUE_USD)*-1,0)
                               ELSE NVL(SUM(ACTUAL_VALUE_USD),0)
                           END AS ACTUAL_BOH_ACT_BK_USD,
                           CASE
                               WHEN upper(INVENTORY_TYPE) LIKE 'RESERVE%' THEN NVL(SUM(ACTUAL_VALUE_USD)*-1,0)
                               ELSE NVL(SUM(ACTUAL_VALUE_USD),0)
                           END AS ACTUAL_BOH_PLN_BK_USD,
                           CASE
                               WHEN upper(INVENTORY_TYPE) LIKE 'RESERVE%' THEN NVL(SUM(ACTUAL_VALUE_USD)*-1,0)
                               ELSE NVL(SUM(ACTUAL_VALUE_USD),0)
                           END AS ACTUAL_BOH_UPD_BK_USD,
                           NULL AS NET_TCGM_VALUE_USD
   FROM FIN_ADJUST_INV_VISIBILITY_F fin_adj
   JOIN stg_d56_item_no stg_d56 ON fin_adj.d56_item_no = stg_d56.d56_item_no
   JOIN stg_loc_hierarchy stg_loc ON fin_adj.AFFILIATE_CODE = stg_loc.loc
   WHERE YEAR=${YEAR}
     AND PERIOD=${PERIOD}
   GROUP BY AFFILIATE_CODE,
            stg_d56.GROUPDESC,
            stg_loc.LOC_DESC,
            INVENTORY_TYPE) FIN_ADJ
GROUP BY FIN_ADJ.AFFILIATE_CODE,
         FIN_ADJ.GROUP_DESC,
         FIN_ADJ.AFFILIATE_DESC;