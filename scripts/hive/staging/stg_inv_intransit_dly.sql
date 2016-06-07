USE ${DATABASE};

INSERT overwrite TABLE stg_inv_intransit_dly partition(YEAR=${EFF_YEAR}, period=${EFF_PERIOD})
SELECT lnd_dly.material,
       lnd_dly.plant,
       lnd_dly.po_doc,
       lnd_dly.po_item,
       lnd_dly.suppl_plant,
       lnd_dly.special_stock,
       lnd_dly.qty,
       lnd_dly.base_uom,
       tmp_mat.std_cost,
       lnd_dly.intrans_typ,
       CURRENT_DATE,
       '${USER_NAME}'
FROM lnd_inv_intransit_dly lnd_dly
LEFT OUTER JOIN tmp_material_cost tmp_mat ON lnd_dly.material=tmp_mat.material
AND lnd_dly.plant=tmp_mat.plant
AND tmp_mat.YEAR=${EFF_YEAR}
AND tmp_mat.period=${EFF_PERIOD}