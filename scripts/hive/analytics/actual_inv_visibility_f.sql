USE ${DATABASE};


SET hive.exec.dynamic.partition=TRUE;
SET hive.exec.dynamic.partition.mode=non-STRICT;


INSERT overwrite TABLE actual_inv_visibility_f partition(inventory_type,YEAR, period)
SELECT stg_inv.material_id,
       stg_inv.jda_aff_cde,
       stg_inv.jda_d56_item_no,
       concat(stg_inv.year,LPAD(stg_inv.period,2,'00'),'01') AS cal_period,
       'SAP' AS source_type,
       stg_inv.plant_id,
       stg_inv.company_cde as company_code,
       stg_inv.total_stock_qty AS actual_units,
       stg_inv.amt_local_curr AS actual_local_value,
       stg_inv.amt_local_curr*exch_rate.actual_book_exchange_rate AS actual_value_usd,
       stg_inv.amt_local_curr*exch_rate.plan_book_exchange_rate AS plan_value_usd,
       stg_inv.amt_local_curr*ROUND(exch_rate.update_book_exchange_rate,2) AS update_value_usd,
       stg_inv.std_cost AS std_local_cost,
       (stg_inv.amt_local_curr*exch_rate.plan_book_exchange_rate) - NVL(NVL(STG_ITEM.CEU_FACTOR,0) * NVL(stg_tcgm.FACT,0) /stg_item.sell_stock_conv,0) AS net_tcgm_value_usd,
       (stg_inv.total_stock_qty/stg_item.sell_stock_conv) * stg_item.d56_conv_factor_ceu * stg_item.ceu_factor AS ceu,
       '${USER_NAME}' AS created_by,
       CURRENT_DATE AS created_date,
                       '${USER_NAME}' AS last_upd_by,
                       CURRENT_DATE AS last_upd_date,
                                       stg_inv.inventory_typ AS inventory_type,
                                       stg_inv.year,
                                       stg_inv.period
FROM mosc_dev_plng_ivis_hive.stg_inv_visibility stg_inv
LEFT OUTER JOIN mosc_dev_plng_ivis_hive.exchange_rate_d exch_rate ON stg_inv.currency = exch_rate.conversion_from_code
AND UPPER(exch_rate.conversion_to_code)=UPPER('USD')
AND date_fk = cast(concat(stg_inv.year,LPAD(stg_inv.period,2,'0'),'01') AS int)
AND UPPER(exch_rate.major_business)=UPPER('Pharma')
LEFT OUTER JOIN mosc_dev_plng_ivis_hive.stg_item stg_item ON stg_inv.material_id = stg_item.item_code
AND stg_inv.jda_aff_cde = stg_item.loc
LEFT OUTER JOIN mosc_dev_plng_ivis_hive.stg_tcgm stg_tcgm ON stg_inv.jda_d56_item_no = stg_tcgm.d56_item_no
AND stg_inv.jda_aff_cde = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd') = concat(YEAR,LPAD(PERIOD,2,'00'),'01')
WHERE YEAR=${YEAR}
  AND period=${PERIOD};
