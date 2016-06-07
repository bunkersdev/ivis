USE ${DATABASE};

INSERT overwrite TABLE stg_sap_plant_company_master 
select lnd_sap.plant ,
       lnd_sap.name,
       lnd_sap.valuation_area ,
       lnd_sap.company_code ,
       lnd_sap.plant_cust ,
       lnd_sap.plant_vendor ,
       lnd_sap.aff_code ,
       lnd_sap.warehouse ,
       lnd_sap.currency,
       current_date, 
       '${USER_NAME}' 
       from (
SELECT B.plant ,
       B.name,
       B.valuation_area ,
       B.company_code ,
       B.plant_cust ,
       B.plant_vendor ,
       B.aff_code ,
       B.warehouse ,
       B.currency
FROM lnd_sap_plant_company_master B
WHERE B.plant IN
    (SELECT A.plant
     FROM lnd_sap_plant_company_master A
     GROUP BY A.plant HAVING count(*)=1)

UNION ALL

SELECT B.plant ,
       B.name,
       B.valuation_area ,
       B.company_code ,
       B.plant_cust ,
       B.plant_vendor ,
       B.aff_code ,
       B.warehouse ,
       B.currency
FROM lnd_sap_plant_company_master B
WHERE B.plant IN
    (SELECT A.plant
     FROM lnd_sap_plant_company_master A
     GROUP BY A.plant HAVING count(*)>1)
     AND B.warehouse='US' ) lnd_sap

