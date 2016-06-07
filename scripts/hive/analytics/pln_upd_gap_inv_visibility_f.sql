SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

USE ${DATABASE};

INSERT overwrite TABLE pln_upd_gap_inv_visibility_f partition(inventory_type, year, period)

SELECT stg_plan.sap_material_no,
       stg_plan.affiliate_code,
       stg_plan.d56_item_no,
       stg_plan.cal_period,
       'WEBSITE',
       stg_plan.units_month,
       stg_plan.local_val_month,
       stg_plan.usd_val_month,
       stg_plan.local_currency,
       CASE
           WHEN stg_plan.inventory_type IN (upper('PLAN-GAP'),
                                            upper('UPDATE-GAP')) THEN usd_val_month
           ELSE usd_val_month - NVL(NVL(stg_item.ceu_factor,0) * NVL(stg_tcgm.fact,0) /stg_item.sell_stock_conv,0)
       END,
       '${USER_NAME}',
       CURRENT_DATE,
       '${USER_NAME}',
       CURRENT_DATE,
       stg_plan.inventory_type,
       stg_plan.year,
       stg_plan.period
FROM
  (SELECT stg_plan.sap_material_no,
          stg_plan.affiliate_code,
          stg_plan.d56_item_no,
          concat(stg_plan.year,'01','01') AS cal_period,
          stg_plan.units_jan AS units_month,
          stg_plan.local_val_jan AS local_val_month,
          stg_plan.usd_val_jan AS usd_val_month,
          stg_plan.local_currency,
          upper(stg_plan.type) AS inventory_type,
          stg_plan.year,
          '01' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'02','01') AS cal_period,
                    stg_plan.units_feb AS units_month,
                    stg_plan.local_val_feb AS local_val_month,
                    stg_plan.usd_val_feb AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '02' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'03','01') AS cal_period,
                    stg_plan.units_mar AS units_month,
                    stg_plan.local_val_mar AS local_val_month,
                    stg_plan.usd_val_mar AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '03' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'04','01') AS cal_period,
                    stg_plan.units_apr AS units_month,
                    stg_plan.local_val_apr AS local_val_month,
                    stg_plan.usd_val_apr AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '04' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'05','01') AS cal_period,
                    stg_plan.units_may AS units_month,
                    stg_plan.local_val_may AS local_val_month,
                    stg_plan.usd_val_may AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '05' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'06','01') AS cal_period,
                    stg_plan.units_jun AS units_month,
                    stg_plan.local_val_jun AS local_val_month,
                    stg_plan.usd_val_jun AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '06' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'07','01') AS cal_period,
                    stg_plan.units_jul AS units_month,
                    stg_plan.local_val_jul AS local_val_month,
                    stg_plan.usd_val_jul AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '07' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'08','01') AS cal_period,
                    stg_plan.units_aug AS units_month,
                    stg_plan.local_val_aug AS local_val_month,
                    stg_plan.usd_val_aug AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '08' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'09','01') AS cal_period,
                    stg_plan.units_sep AS units_month,
                    stg_plan.local_val_sep AS local_val_month,
                    stg_plan.usd_val_sep AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '09' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'10','01') AS cal_period,
                    stg_plan.units_oct AS units_month,
                    stg_plan.local_val_oct AS local_val_month,
                    stg_plan.usd_val_oct AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '10' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'11','01') AS cal_period,
                    stg_plan.units_nov AS units_month,
                    stg_plan.local_val_nov AS local_val_month,
                    stg_plan.usd_val_nov AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '11' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}
   UNION ALL SELECT stg_plan.sap_material_no,
                    stg_plan.affiliate_code,
                    stg_plan.d56_item_no,
                    concat(stg_plan.year,'12','01') AS cal_period,
                    stg_plan.units_dec AS units_month,
                    stg_plan.local_val_dec AS local_val_month,
                    stg_plan.usd_val_dec AS usd_val_month,
                    stg_plan.local_currency,
                    upper(stg_plan.type) AS inventory_type,
                    stg_plan.year,
                    '12' AS period
   FROM stg_plan_upd_gap stg_plan
   WHERE YEAR=${YEAR}) stg_plan
LEFT OUTER JOIN stg_item stg_item ON stg_plan.sap_material_no = stg_item.item_code
AND stg_plan.affiliate_code = stg_item.loc
LEFT OUTER JOIN stg_tcgm stg_tcgm ON stg_plan.d56_item_no = stg_tcgm.d56_item_no
AND stg_plan.affiliate_code = stg_tcgm.reporting_affiliate
AND from_unixtime(unix_timestamp(month_date,'yyyy-MM-dd'),'yyyyMMdd')=concat(stg_plan.year,stg_plan.period,'01')