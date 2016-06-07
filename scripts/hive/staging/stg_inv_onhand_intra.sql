USE ${DATABASE};

INSERT overwrite TABLE stg_inv_onhand_intra partition (year=${YEAR}, period=${PERIOD})
SELECT stg_mthly_rank.material_id, 
  CASE 
    WHEN ( 
 stg_mthly_rank.material_id IS NULL
      OR stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_material.material_desc, -2) 
  END AS material_desc, 
  CASE 
    WHEN ( 
 stg_mthly_rank.material_id IS NULL
      OR stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_material.material_typ, -2) 
  END AS material_typ, 
  stg_mthly_rank.plant_id, 
  CASE 
    WHEN ( 
 stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_company.company_code, -2) 
  END AS company_cde, 
  CASE 
    WHEN ( 
 stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_company.warehouse, -2) 
  END AS warehouse_cde, 
  CASE 
    WHEN ( 
 stg_mthly_rank.material_id IS NULL
      OR stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_material.web_sap_d56_item_no, -2) 
  END AS sap_d56_item_no, 
  CASE 
    WHEN ( 
 stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_company.aff_code, -2) 
  END AS jda_aff_cde, 
  stg_mthly_rank.std_cost, 
  stg_mthly_rank.base_uom, 
  CASE 
    WHEN ( 
 stg_mthly_rank.plant_id IS NULL) THEN -1
    ELSE nvl(stg_company.currency, -2) 
  END AS currency, 
  sum(stg_mthly_rank.total_stock_qty)  AS total_stock_qty, 
sum(stg_mthly_rank.total_value) AS amt_local_curr, 
  'ONHAND'   AS inventory_typ,
  concat(stg_mthly_rank.year,LPAD(stg_mthly_rank.period,2,'00')) AS ACTUAL_YEAR_PERIOD, 
  current_date AS insert_dt, 
  '${USER_NAME}' AS created_by 
FROM     ( 
    SELECT   
      stg_mthly.material_id, 
      stg_mthly.plant_id, 
      stg_mthly.base_uom, 
      stg_mthly.std_cost, 
      stg_mthly.year as year,
      stg_mthly.period as period,
      stg_mthly.total_stock_qty,
      stg_mthly.total_value as total_value,  
      rank() OVER (partition BY  stg_mthly.material_id, stg_mthly.plant_id ORDER BY stg_mthly.year DESC, stg_mthly.period DESC ) AS rank
    FROM     stg_inv_onhand_mthly stg_mthly 
    WHERE    ( 
 concat(YEAR,lpad(period,2,'00'))<=concat('${YEAR}','${PERIOD}')
AND stg_mthly.batch=''
)) stg_mthly_rank 
LEFT OUTER JOIN stg_sap_material_master stg_material 
ON stg_mthly_rank.material_id = stg_material.material_id 
AND      stg_mthly_rank.plant_id = stg_material.plant_id 
LEFT OUTER JOIN stg_sap_plant_company_master stg_company 
ON stg_mthly_rank.plant_id = stg_company.plant_id 
WHERE    stg_mthly_rank.rank = 1 
AND stg_mthly_rank.total_stock_qty>0
GROUP BY 
  stg_material.batch_mgn_ind, 
  stg_mthly_rank.material_id, 
  material_desc, 
  material_typ, 
  stg_mthly_rank.plant_id, 
  company_code, 
  warehouse, 
  web_sap_d56_item_no, 
  aff_code, 
  stg_mthly_rank.std_cost, 
  stg_mthly_rank.base_uom, 
  stg_company.currency,
  stg_mthly_rank.year,
  stg_mthly_rank.period;