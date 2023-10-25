-- SQL_EXPORT_M10
SELECT a.customer_code, a.part_no, a.part_name, a.latest_engineering_change_no, a.material_code, c.material_name, a.material_shape_code, b.material_shape_name, a.material_diameter, a.part_length FROM m_parts a LEFT OUTER JOIN m_material_shapes b ON a.material_shape_code = b.material_shape_code LEFT OUTER JOIN m_materials c ON a.material_code = c.material_code ORDER BY a.part_no
