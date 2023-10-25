-- SQL_GET_ALL
SELECT a.part_no,a.engineering_change_no,a.material_code,COALESCE(b.material_name,'') AS material_name,a.material_shape_code,COALESCE(c.material_shape_name,'') AS material_shape_name,a.input_method_type,a.net_material_cost,a.material_basic_unit_price,a.material_cost_correction_amount,a.registration_DATE FROM t_material_price_calculations AS a LEFT OUTER JOIN m_materials AS b ON b.material_code = a.material_code LEFT OUTER JOIN m_material_shapes AS c ON c.material_shape_code = a.material_shape_code WHERE a.part_no &^ ? ORDER BY a.part_no, a.engineering_change_no


