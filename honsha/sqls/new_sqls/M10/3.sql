-- SQL_GET
SELECT a.part_no, a.latest_engineering_change_no, a.part_name, a.is_corrected_material_cost, a.material_code, COALESCE(b.material_name,'') AS material_name, a.material_basic_unit_price, a.material_cost, a.material_cost_correction_amount, a.remarks, a.version_no, a.material_shape_code, a.material_diameter, a.part_length, a.customer_code, COALESCE(c.customer_name,'') AS customer_name FROM m_parts a LEFT OUTER JOIN m_materials b ON a.material_code = b.material_code LEFT OUTER JOIN m_customers c ON a.customer_code = c.customer_code
-- SQL_GET_WHERE_CLAUSE
WHERE a.part_no = ?


