USE ${DATABASE};

INSERT into TABLE err_inv_visibility partition(inventory_typ='ONHAND', year=${YEAR}, period=${PERIOD}) 
SELECT material_id,
       material_desc,
       material_typ,
       primary_plant_id,
       primary_company_code,
       NULL AS suppl_plant,
               NULL AS supply_company_cde,
                       WAREHOUSE,
                       jda_d56_item_no,
                       sap_d56_item_no,
                       primary_affiliate_code,
                       std_cost,
                       BASE_UOM,
                       SUM(amt_local_curr),
                       currency,
                       SUM(total_stock_qty),
                       COST_OVERRIDE_FLG,
                       CURRENT_DATE AS insert_dt,
                                       '${USER_NAME}' AS created_by
FROM
  (SELECT stg_onhand.material_id,
          stg_onhand.material_desc,
          stg_onhand.material_typ,
          prim_plant.primary_plant_id,
          prim_plant.primary_company_code,
          STG_COMPANY.WAREHOUSE,
          NVL(spec_item.d56_item_no, nonspec_item.d56_item_no) AS jda_d56_item_no,
          stg_onhand.sap_d56_item_no,
          prim_plant.primary_affiliate_code,
          NVL(MAT_COST.STD_COST, PRIM_PLNT_COST.STD_COST) AS STD_COST,
          NVL(MAT_COST.BASE_UOM, PRIM_PLNT_COST.BASE_UOM) AS BASE_UOM,
          CASE WHEN (MAT_COST.STD_COST IS NOT NULL) 
            THEN 'N' 
            ELSE 'Y' 
            END AS COST_OVERRIDE_FLG,
          stg_onhand.amt_local_curr,
          STG_COMPANY.currency,
          stg_onhand.total_stock_qty
   FROM stg_inv_onhand_intra stg_onhand
   LEFT OUTER JOIN
     (SELECT DISTINCT AFF_CDE.AFFILIATE_CODE,
                      prim_plant.plant AS primary_plant_id,
                      prim_plant.affiliate_code AS primary_affiliate_code,
                      prim_plant.company_code AS primary_company_code
      FROM stg_primary_plant_lookup aff_cde
      JOIN stg_primary_plant_lookup prim_plant
      WHERE aff_cde.GROUP_NUM= prim_plant.GROUP_NUM
        AND UPPER(prim_plant.primary_ind)=UPPER('x')) prim_plant ON stg_onhand.jda_aff_cde = prim_plant.affiliate_code
   LEFT OUTER JOIN
     (SELECT D56_ITEM_NO,
             ITEM_CODE,
             LOC AS AFFILIATE
      FROM STG_ITEM
      WHERE ITEM_CODE <> 'NONSPCFC') AS SPEC_ITEM ON STG_ONHAND.MATERIAL_ID = SPEC_ITEM.ITEM_CODE
   AND PRIM_PLANT.PRIMARY_AFFILIATE_CODE=SPEC_ITEM.AFFILIATE
   LEFT OUTER JOIN
     (SELECT D56_ITEM_NO,
             LOC AS AFFILIATE
      FROM STG_ITEM
      WHERE ITEM_CODE = 'NONSPCFC') AS NONSPEC_ITEM ON PRIM_PLANT.PRIMARY_AFFILIATE_CODE=NONSPEC_ITEM.AFFILIATE
   LEFT OUTER JOIN STG_SAP_PLANT_COMPANY_MASTER STG_COMPANY ON PRIM_PLANT.PRIMARY_PLANT_ID = STG_COMPANY.PLANT_ID
   LEFT OUTER JOIN
     (SELECT MATERIAL,
             PRIMARY_PLANT,
             STD_COST,
             BASE_UOM,
             YEAR,
             PERIOD
      FROM TMP_MATERIAL_COST
      WHERE PLANT=PRIMARY_PLANT) AS MAT_COST ON STG_ONHAND.MATERIAL_ID= MAT_COST.MATERIAL
   AND PRIM_PLANT.PRIMARY_PLANT_ID=MAT_COST.PRIMARY_PLANT
   AND STG_ONHAND.YEAR= MAT_COST.YEAR
   AND STG_ONHAND.PERIOD= MAT_COST.PERIOD
      LEFT OUTER JOIN
     (SELECT MATERIAL,
             PRIMARY_PLANT,
             STD_COST,
             BASE_UOM,
             YEAR,
             PERIOD
      FROM TMP_MAT_PRIM_PLANT_COST) AS PRIM_PLNT_COST ON STG_ONHAND.MATERIAL_ID= PRIM_PLNT_COST.MATERIAL
   AND PRIM_PLANT.PRIMARY_PLANT_ID=PRIM_PLNT_COST.PRIMARY_PLANT
   AND STG_ONHAND.YEAR= PRIM_PLNT_COST.YEAR
   AND STG_ONHAND.PERIOD= PRIM_PLNT_COST.PERIOD
   WHERE stg_onhand.YEAR=${YEAR}
     AND stg_onhand.period=${PERIOD}
     AND prim_plant.primary_plant_id IS NULL) ONHAND
GROUP BY material_id,
         material_desc,
         material_typ,
         primary_plant_id,
         primary_company_code,
         WAREHOUSE,
         jda_d56_item_no,
         sap_d56_item_no,
         primary_affiliate_code,
         std_cost,
         BASE_UOM,
         currency,
         COST_OVERRIDE_FLG;