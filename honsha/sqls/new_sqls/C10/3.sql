-- SQL_GET
SELECT a.part_no ,a.part_name ,a.latest_engineering_change_no AS engineering_change_no ,a.is_corrected_material_cost ,a.material_code ,a.material_basic_unit_price ,a.material_cost ,a.material_cost_correction_amount ,a.material_diameter ,a.part_length ,a.material_shape_code ,a.customer_code ,CASE WHEN b.seq_no IS NULL THEN '' ELSE '管理図面' END AS 図面type FROM m_parts AS a LEFT OUTER JOIN t_drawings AS b ON b.part_no = a.part_no AND b.drawing_type = '1'
-- SQL_GET_WHERE_CLAUSE
WHERE a.part_no = ?
-- SQL_GET_LIMIT
LIMIT 1
