-- SQL_REPORT_71_SELECT_TEMPLATE
SELECT a.part_no ,a.engineering_change_no ,COALESCE(b.part_name,'') AS part_name ,a.material_code ,COALESCE(c.material_name,'') AS material_name ,a.material_shape_code ,COALESCE(d.material_shape_name,'') AS material_shape_name ,a.material_diameter ,a.material_length ,a.part_length ,a.remain_material_length ,a.input_method_type ,a.material_basic_unit_price ,a.material_weight ,a.material_unit_price ,a.yeild ,a.material_cost ,a.part_material_weight ,a.part_weight ,a.waste_recovery_rate ,a.waste_unit_price ,a.waste_price ,a.net_material_cost ,a.material_cost_correction_amount ,a.registration_DATE %s %s %s
-- SQL_REPORT_71_COMMON
FROM t_material_price_calculations AS a LEFT OUTER JOIN m_parts AS b ON b.part_no = a.part_no LEFT OUTER JOIN m_materials AS c ON c.material_code = a.material_code LEFT OUTER JOIN m_material_shapes AS d ON d.material_shape_code = a.material_shape_code
    -- SQL_REPORT_71_WHERE_HINBAN
    WHERE a.part_no &^ ?
    -- SQL_REPORT_71_ORDERBY
    ORDER BY a.part_no, a.engineering_change_no


