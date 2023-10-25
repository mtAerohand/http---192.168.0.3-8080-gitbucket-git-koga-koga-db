-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.part_no) AS INT) FROM t_material_price_calculations AS a LEFT OUTER JOIN m_materials AS b ON b.material_code = a.material_code LEFT OUTER JOIN m_material_shapes AS c ON c.material_shape_code = a.material_shape_code WHERE a.part_no &^ ?


