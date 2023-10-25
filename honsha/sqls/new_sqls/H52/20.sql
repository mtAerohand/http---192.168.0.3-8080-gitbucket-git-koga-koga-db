-- SQL_REPORT_63_SHOUSAI
SELECT a.inventory_month ,a.supplier_code ,COALESCE(b.supplier_name,'') AS supplier_name ,CASE a.type WHEN '1' THEN '仕掛品' ELSE '材料' END AS type ,CASE a.type WHEN '1' THEN a.part_no ELSE a.material_name END AS part_no_material ,CASE a.type WHEN '1' THEN a.engineering_change_no ELSE '' END AS engineering_change_no ,CASE a.type WHEN '1' THEN COALESCE(c.part_name,'') ELSE a.shape END AS part_nameshape ,CASE a.type WHEN '1' THEN a.quantity ELSE a.weight END AS quantity ,a.unit_price ,CASE a.type WHEN '1' THEN a.assessment_rate ELSE NULL END AS assessment_rate ,CASE a.type WHEN '1' THEN a.assessment_unit_price ELSE NULL END AS assessment_unit_price ,a.price FROM t_inventories AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no WHERE a.inventory_month = ? %s %s
    -- SQL_REPORT_63_SHOUSAI_SHIIRESAKI(%s1)
    AND a.supplier_code = ?
-- SQL_REPORT_63_SHOUSAI_SAGYOUKU_ORDER_BY(%s2)
ORDER BY COALESCE(b.sort_no,0), a.supplier_code, a.type, part_no_material, engineering_change_no, part_nameshape


