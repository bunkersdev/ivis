USE ${DATABASE};

INSERT overwrite TABLE stg_sap_material_master 
SELECT 
material_id, 
plant_id, 
mat_del_flg, 
material_typ, 
base_uom, 
batch_mgn_ind, 
material_desc, 
sap_d56_item_no,
web_sap_d56_item_no,
current_date, 
'${USER_NAME}'
FROM
(
SELECT
material_id, 
plant_id, 
mat_del_flg, 
material_typ, 
base_uom, 
batch_mgn_ind, 
material_desc, 
sap_d56_item_no,
web_sap_d56_item_no,
rank() OVER (partition BY material_id, plant_id, mat_del_flg, material_typ, base_uom, batch_mgn_ind, material_desc, sap_d56_item_no, web_sap_d56_item_no ORDER BY insert_dt DESC) AS rank
FROM stg_sap_material_master_history
) material_master_history_rank
WHERE material_master_history_rank.rank = 1;