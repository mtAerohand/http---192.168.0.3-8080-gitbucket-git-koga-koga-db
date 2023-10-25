-- SQL_GET_WITH_MATERIAL
SELECT a.part_no ,a.part_name ,a.latest_engineering_change_no AS engineering_change_no ,a.is_corrected_material_cost ,a.material_code ,a.material_basic_unit_price ,a.material_cost ,a.material_cost_correction_amount ,a.material_diameter ,a.part_length ,a.material_shape_code ,a.customer_code ,b.material_name ,b.specific_gravity FROM m_parts AS a LEFT OUTER JOIN m_materials AS b ON b.material_code = a.material_code
-- SQL_GET_WHERE_CLAUSE
WHERE a.part_no = ?
-- SQL_GET_LIMIT
LIMIT 1
