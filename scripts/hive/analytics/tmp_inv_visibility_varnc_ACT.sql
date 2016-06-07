USE ${DATABASE};

INSERT overwrite TABLE tmp_inv_visibility partition(TYPE='ACTUAL', YEAR=${YEAR}, MONTH=${PERIOD})
SELECT AFFILIATE_CODE AS AFFILIATE_CODE,
       stg_d56.GROUPDESC AS GROUP_DESC,
       stg_loc.LOC_DESC AS AFFILIATE_DESC,
       act_inv.plant_id as PLANT_ID,
       act_inv.company_code as company_code,
       SUM(ACTUAL_VALUE_USD) AS ACTUAL_BOH_ACT_BK_USD,
       SUM(PLAN_VALUE_USD) AS ACTUAL_BOH_PLN_BK_USD,
       SUM(UPDATE_VALUE_USD) AS ACTUAL_BOH_UPD_BK_USD,
       SUM(NET_TCGM_VALUE_USD) AS NET_TCGM_VALUE_USD
FROM actual_inv_visibility_f act_inv
JOIN stg_d56_item_no stg_d56 ON act_inv.d56_item_no = stg_d56.d56_item_no
JOIN stg_loc_hierarchy stg_loc ON act_inv.AFFILIATE_CODE = stg_loc.loc
WHERE YEAR=${YEAR}
  AND PERIOD=${PERIOD}
GROUP BY AFFILIATE_CODE,
         stg_d56.GROUPDESC,
         stg_loc.LOC_DESC,
act_inv.plant_id, act_inv.company_code;