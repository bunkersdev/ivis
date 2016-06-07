#! /bin/bash -e

hadoop fs -rm -r $1/ivis/temp/send_err_inv_visibility/*

hive -e "
USE $2;

INSERT OVERWRITE DIRECTORY '$1/ivis/temp/send_err_inv_visibility' 

select 

concat_ws(',',material_id
,material_typ
,plant_id
,company_cde
,NVL(supply_plant_id,' ')
,NVL(supply_company_cde,' ')
,NVL(warehouse_cde,' ')
,jda_d56_item_no
,sap_d56_item_no
,NVL(jda_aff_cde,' ')
,cast(cast(std_cost as decimal(25,10)) as string)
,base_uom
,cast(cast(amt_local_curr as decimal(25,10)) as string)
,currency
,cast(cast(total_stock_qty as decimal(25,10)) as string)
,inventory_typ
,cast(year as string)
,cast(period as string))
 from err_inv_visibility
"




