USE ${DATABASE};

INSERT overwrite TABLE stg_inv_onhand_dly 
SELECT   TABLE, 
         material, 
         plant, 
         sloc, 
         batch, 
         spec_stock, 
         vendor, 
         customer, 
         unrestr_qty, 
         qi_qty, 
         restr_qty, 
         blocked_qty, 
         return_qty, 
         intrans_qty, 
         sum(nvl(total_qty,0)) AS total_stock_qty,
         base_uom, 
         std_cost,
          sum(nvl(total_value,0)) AS total_value, 
         current_date, 
         '${USER_NAME}'
FROM     lnd_inv_onhand_dly 
WHERE total_qty > 0
AND batch = ''
GROUP BY TABLE, 
         material, 
         plant, 
         sloc, 
         batch, 
         spec_stock, 
         vendor, 
         customer, 
         unrestr_qty, 
         qi_qty, 
         restr_qty, 
         blocked_qty, 
         return_qty, 
         intrans_qty, 
         base_uom, 
         std_cost;