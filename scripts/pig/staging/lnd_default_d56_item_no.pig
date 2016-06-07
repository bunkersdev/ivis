lnd_default_d56_item_no = LOAD '${IVIS_HIVE_DATABASE}.lnd_default_d56_item_no' USING org.apache.hive.hcatalog.pig.HCatLoader();
add_prod_type = FOREACH lnd_default_d56_item_no GENERATE 
invtype,
listno,
packsize,
labelcode,
sizecode,
listdesc,
line,
linedesc,
subline,
sublinedesc,
groupcode,
groupdesc,
subgroup,
subgroupdesc,
formcode,
formcodedesc,
packcodedesc,
ceuuom,
ceufactor,
'NULL' as created_by,
'NULL' as creation_date,
'NULL' as last_upd_by,
'NULL' as last_upd_date,
status,
'NULL' as source,
'NULL' as datamart_last_upd_by,
'NULL' as datamart_last_upd_date,
'NULL' as original_insert_date,
'NULL' as last_date_sent_rgm,
'NULL' as last_date_upd_web,
'NULL' as last_date_sent_valid,
alt_ceuuom,
alt_ceufactor,
'NULL' as alt_ceucomment,
CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(invtype,'-'),CONCAT(listno,'-')),CONCAT(labelcode,'-')),CONCAT(sizecode,'-')),packsize) as d56_item_no,
'Y' as prod_type;

store_stg_d56_item = STORE add_prod_type into '${IVIS_HIVE_DATABASE}.stg_d56_item_no' using org.apache.hive.hcatalog.pig.HCatStorer();




