USE ${DATABASE};

INSERT overwrite TABLE stg_primary_plant_lookup 
SELECT prim.plant,
	   prim.name,
	   prim.affiliate_code,
	   prim.valuation_area,
	   prim.sales_org,
	   prim.company_code,
	   loc.level_10_desc as display_name,
	   lower(prim.primary_ind),
	   prim.group_num,
       current_date, 
       '${USER_NAME}'
FROM   lnd_primary_plant_lookup prim
JOIN stg_loc_hierarchy loc
ON prim.affiliate_code = loc.level_10_code;