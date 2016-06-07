USE ${DATABASE};

INSERT OVERWRITE TABLE STG_INV_INTER_INTRANSIT partition(year=${YEAR},period=${PERIOD})
SELECT STG_DLY.material_id, 
CASE WHEN STG_DLY.material_id IS NULL OR STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_MATMAS.material_desc, -2) END AS MATERIAL_DESC,
CASE WHEN STG_DLY.material_id IS NULL OR STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_MATMAS.material_typ, -2) END AS MATERIAL_TYP, 
STG_DLY.plant_id, 
STG_DLY.suppl_plant,
CASE WHEN STG_DLY.suppl_plant IS NULL THEN -1 ELSE Nvl(STG_PLTCO_SUPP.company_code, -2) END AS SUPPLY_COMPANY_CDE, 
CASE WHEN STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_PLTCO.company_code, -2) END AS COMPANY_CDE, 
CASE WHEN STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_PLTCO.warehouse, -2) END AS WAREHOUSE_CDE, 
CASE WHEN STG_DLY.material_id IS NULL OR STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_MATMAS.WEB_SAP_D56_ITEM_NO, -2) END AS SAP_D56_ITEM_NO, 
CASE WHEN STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_PLTCO.aff_code, -2) END AS JDA_AFF_CDE, 
STG_DLY.std_cost, 
STG_DLY.base_uom,
CASE WHEN STG_DLY.material_id IS NULL OR STG_DLY.plant_id IS NULL THEN -1 ELSE Nvl(STG_PLTCO.currency, -2) END AS CURRENCY,
Sum(STG_DLY.qty) AS TOTAL_STOCK_QTY,
Sum(STG_DLY.qty) * STG_DLY.std_cost AMT_LOCAL_CURR,
'INTERCO' AS INVENTORY_TYP,
CURRENT_DATE AS INSERT_DT,
'${USER_NAME}' AS CREATED_BY
FROM stg_inv_intransit_dly STG_DLY 
       LEFT OUTER JOIN stg_sap_material_master STG_MATMAS 
                    ON STG_DLY.material_id = STG_MATMAS.material_id 
                       AND STG_DLY.plant_id = STG_MATMAS.plant_id 
       LEFT OUTER JOIN stg_sap_plant_company_master STG_PLTCO 
                    ON STG_DLY.plant_id = STG_PLTCO.plant_id 
       LEFT OUTER JOIN stg_sap_plant_company_master STG_PLTCO_SUPP 
                    ON STG_DLY.plant_id = STG_PLTCO_SUPP.plant_id
WHERE STG_DLY.YEAR = ${YEAR}
AND STG_DLY.PERIOD = ${PERIOD}      
AND STG_DLY.intrans_typ=1   
AND STG_DLY.qty >0
GROUP BY 
STG_DLY.material_id, 
STG_DLY.plant_id,
STG_MATMAS.material_desc,
STG_MATMAS.material_typ,
STG_DLY.suppl_plant,
STG_PLTCO_SUPP.company_code,
STG_PLTCO.company_code,
STG_PLTCO.warehouse,
STG_MATMAS.web_sap_d56_item_no,
STG_PLTCO.aff_code,
STG_PLTCO.plant_id, 
STG_PLTCO_SUPP.plant_id ,
STG_DLY.std_cost,
STG_DLY.base_uom,
STG_PLTCO.currency; 