USE ${DATABASE};


INSERT overwrite TABLE stg_sap_material_detail
SELECT distinct stg_rank.material_id,
       stg_rank.jda_d56_item_no,
       stg_rank.sap_d56_item_no,
       stg_rank.company_cde,
       stg_rank.plant_id,
       NULL as supply_plant_id,
       NULL as supply_company_cde,
       stg_rank.jda_aff_cde,
       stg_rank.material_desc,
       stg_rank.material_typ,
       stg_rank.std_cost,
       stg_rank.currency,
       stg_rank.base_uom,
       CURRENT_DATE,
       '${USER_NAME}'
FROM 
(
SELECT
material_id,
jda_d56_item_no,
sap_d56_item_no,
company_cde,
plant_id,
jda_aff_cde,
material_desc,
material_typ,
std_cost,
currency,
base_uom,
rank() OVER (partition BY jda_d56_item_no, material_id, plant_id ORDER BY year DESC, period DESC ) AS rank
FROM stg_inv_visibility
WHERE ( 
concat(YEAR,lpad(period,2,'00'))<=concat('${YEAR}','${PERIOD}')
)) stg_rank
WHERE stg_rank.rank = 1;