USE ${DATABASE};

INSERT OVERWRITE TABLE TMP_MATERIAL_COST
SELECT MATERIAL ,
       PLANT ,
       PRIM_PLANT.primary_plant_id as PRIMARY_PLANT,
       STD_COST,
       BASE_UOM,
       ${YEAR} AS YEAR,
       ${PERIOD} AS PERIOD
FROM
  (SELECT MATERIAL ,
          PLANT ,
          STD_COST,
          BASE_UOM,
          TOTAL_QTY,
          RANK() OVER (PARTITION BY MATERIAL , PLANT 
                       ORDER BY YEAR DESC, PERIOD DESC) AS RANK
   FROM LND_INV_ONHAND_MTHLY LND_MTHLY
   WHERE CONCAT(YEAR,PERIOD)<=CONCAT(${YEAR},${PERIOD})
   AND BATCH=''
      ) LND_MTHLY
  LEFT OUTER JOIN
  (SELECT distinct aff_cde.plant AS plant_id,
          prim_plant.plant AS primary_plant_id,
          prim_plant.affiliate_code AS primary_affiliate_code,
          prim_plant.company_code AS primary_company_code
   FROM stg_primary_plant_lookup aff_cde
   JOIN stg_primary_plant_lookup prim_plant
   WHERE aff_cde.GROUP_NUM= prim_plant.GROUP_NUM
     AND UPPER(prim_plant.primary_ind)=UPPER('x')) PRIM_PLANT ON LND_MTHLY.PLANT= PRIM_PLANT.PLANT_ID
  LEFT OUTER JOIN stg_sap_plant_company_master stg_company 
ON PRIM_PLANT.primary_plant_id = stg_company.plant_id 
WHERE RANK=1
AND STD_COST IS NOT NULL
;