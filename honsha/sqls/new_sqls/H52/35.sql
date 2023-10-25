-- SQL_REPORT_71_COUNT_TEMPLATE
SELECT CAST(COUNT(a.part_no) AS INT) %s %s %s
-- SQL_REPORT_71_COMMON
FROM t_material_price_calculations AS a LEFT OUTER JOIN m_parts AS b ON b.part_no = a.part_no LEFT OUTER JOIN m_materials AS c ON c.material_code = a.material_code LEFT OUTER JOIN m_material_shapes AS d ON d.material_shape_code = a.material_shape_code
    -- SQL_REPORT_71_WHERE_HINBAN
    WHERE a.part_no &^ ?
    -- SQL_REPORT_71_ORDERBY
    ORDER BY a.part_no, a.engineering_change_no


