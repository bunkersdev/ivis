USE ${DATABASE};

INSERT OVERWRITE TABLE TMP_MAT_PRIM_PLANT_COST
SELECT MATERIAL ,
       PRIMARY_PLANT,
       MAX(STD_COST),
       BASE_UOM,
       YEAR,
       PERIOD
FROM
TMP_MATERIAL_COST
GROUP BY
MATERIAL,
PRIMARY_PLANT,
BASE_UOM,
YEAR,
PERIOD;