USE ${DATABASE};

INSERT into TABLE stg_sap_material_master_history
SELECT matnr, 
       werks, 
       lvorm, 
       mtart, 
       meins, 
       xchpf, 
       maktx, 
       d56,
       concat(substr(d56, 1, 17), substr(d56, 19, 3)),
       current_timestamp, 
       '${USER_NAME}'
FROM   lnd_sap_material_master;