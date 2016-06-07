
lnd_d56_item_no = LOAD '${IVIS_HIVE_DATABASE}.lnd_d56_item_no' USING org.apache.hive.hcatalog.pig.HCatLoader();
add_prod_type  = FOREACH lnd_d56_item_no GENERATE
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
created_by,
creation_date,
last_upd_by,
last_upd_date,
status,
source,
datamart_last_upd_by,
datamart_last_upd_date,
original_insert_date,
last_date_sent_rgm,
last_date_upd_web,
last_date_sent_valid,
alt_ceuuom,
alt_ceufactor,
alt_ceucomment,
CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(invtype,'-'),CONCAT(listno,'-')),CONCAT(labelcode,'-')),CONCAT(sizecode,'-')),packsize) as d56_item_no,
'N' as prod_type;

store_stg_d56_item = STORE add_prod_type into '${IVIS_HIVE_DATABASE}.stg_d56_item_no' using org.apache.hive.hcatalog.pig.HCatStorer();











