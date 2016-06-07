set hive.exec.dynamic.partition=true;  
set hive.exec.dynamic.partition.mode=nonstrict;

USE ${DATABASE};

insert overwrite table fin_adjust_inv_visibility_f partition(inventory_type, year, period)
select material_no,
       affiliate_code,
       d56_item_no,
       concat(year,month,'01'),
       'WEBSITE',
       adjusted_value_usd,
       '${USER_NAME}',
       current_date,
       '${USER_NAME}',
       current_date,
       type as inventory_type,
       year,
       month as period
FROM   stg_fin_manual_adjustments
WHERE  year='${YEAR}'
AND    month='${PERIOD}';