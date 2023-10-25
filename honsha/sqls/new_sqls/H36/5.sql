-- SQL_GET_WORKREGION_SELECT
SELECT B.supplier_code, COALESCE(C.supplier_abbreviation,'') AS supplier_name FROM ( SELECT b.management_no FROM ( SELECT part_no, MAX(incoming_order_DATE) AS incoming_order_DATE FROM t_incoming_orders AS x WHERE part_no = ? AND EXISTS (SELECT * FROM t_production_plans WHERE management_no = x.management_no) GROUP BY part_no ) AS a INNER JOIN t_incoming_orders AS b ON b.part_no = a.part_no AND b.incoming_order_DATE = a.incoming_order_DATE AND EXISTS (SELECT * FROM t_production_plans WHERE management_no = b.management_no) LIMIT 1 ) AS A INNER JOIN t_production_plan_details AS B ON B.management_no = A.management_no LEFT OUTER JOIN m_suppliers AS C ON C.supplier_code = B.supplier_code ORDER BY B.process_sort_no


