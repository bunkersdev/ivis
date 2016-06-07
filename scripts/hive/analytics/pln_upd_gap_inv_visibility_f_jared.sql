SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

USE ${DATABASE};

--JAN
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'01','01'),
	   'WEBSITE',
	   stg_plan.units_jan,
	   stg_plan.local_val_jan,
	   stg_plan.usd_val_jan,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_jan ELSE usd_val_jan - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       upper(stg_plan.type) as inventory_type,
       stg_plan.year,
       '01' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'01','01')
WHERE  year='${YEAR}';

--FEB
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'02','01'),
	   'WEBSITE',
	   stg_plan.units_feb,
	   stg_plan.local_val_feb,
	   stg_plan.usd_val_feb,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_feb ELSE usd_val_feb - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '02' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'02','01')
WHERE  year='${YEAR}';

--MAR
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'03','01'),
	   'WEBSITE',
	   stg_plan.units_mar,
	   stg_plan.local_val_mar,
	   stg_plan.usd_val_mar,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_mar ELSE usd_val_mar - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '03' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'03','01')
WHERE  year='${YEAR}';

--APR
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'04','01'),
	   'WEBSITE',
	   stg_plan.units_apr,
	   stg_plan.local_val_apr,
	   stg_plan.usd_val_apr,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_apr ELSE usd_val_apr - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '04' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'04','01')
WHERE  year='${YEAR}';

--MAY
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'05','01'),
	   'WEBSITE',
	   stg_plan.units_may,
	   stg_plan.local_val_may,
	   stg_plan.usd_val_may,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_may ELSE usd_val_may - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '05' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'05','01')
WHERE  year='${YEAR}';

--JUN
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'06','01'),
	   'WEBSITE',
	   stg_plan.units_jun,
	   stg_plan.local_val_jun,
	   stg_plan.usd_val_jun,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_jun ELSE usd_val_jun - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '06' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'06','01')
WHERE  year='${YEAR}';

--JUL
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'07','01'),
	   'WEBSITE',
	   stg_plan.units_jul,
	   stg_plan.local_val_jul,
	   stg_plan.usd_val_jul,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_jul ELSE usd_val_jul - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '07' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'07','01')
WHERE  year='${YEAR}';

--AUG
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'08','01'),
	   'WEBSITE',
	   stg_plan.units_aug,
	   stg_plan.local_val_aug,
	   stg_plan.usd_val_aug,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_aug ELSE usd_val_aug - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '08' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'08','01')
WHERE  year='${YEAR}';

--SEP
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'09','01'),
	   'WEBSITE',
	   stg_plan.units_sep,
	   stg_plan.local_val_sep,
	   stg_plan.usd_val_sep,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_sep ELSE usd_val_sep - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '09' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'09','01')
WHERE  year='${YEAR}';

--OCT
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'10','01'),
	   'WEBSITE',
	   stg_plan.units_oct,
	   stg_plan.local_val_oct,
	   stg_plan.usd_val_oct,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_oct ELSE usd_val_oct - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '10' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'10','01')
WHERE  year='${YEAR}';

--NOV
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'11','01'),
	   'WEBSITE',
	   stg_plan.units_nov,
	   stg_plan.local_val_nov,
	   stg_plan.usd_val_nov,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_nov ELSE usd_val_nov - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '11' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'11','01')
WHERE  year='${YEAR}';

--DEC
INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)
SELECT stg_plan.sap_material_no,
	   stg_plan.affiliate_code,
       stg_plan.d56_item_no,
	   concat(stg_plan.year,'12','01'),
	   'WEBSITE',
	   stg_plan.units_dec,
	   stg_plan.local_val_dec,
	   stg_plan.usd_val_dec,
	   stg_plan.local_currency,
	   CASE WHEN stg_plan.type IN (upper('PLAN GAP'),upper('UPDATE GAP')) THEN usd_val_dec ELSE usd_val_dec - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0) END,
	   '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       stg_plan.type as inventory_type,
       stg_plan.year,
       '12' as period
FROM   stg_plan_upd_gap stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(stg_plan.year,'12','01')
WHERE  year='${YEAR}';