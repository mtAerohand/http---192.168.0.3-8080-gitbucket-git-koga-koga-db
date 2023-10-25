-- SQL_GET_AccEPT
SELECT a.management_no ,a.incoming_order_no ,a.branch_no ,a.part_no ,a.engineering_change_no ,COALESCE(g.production_quantity,0) AS production_quantity ,COALESCE(e.supplier_abbreviation,'') AS supplier_name ,d.acceptance_DATE ,CASE WHEN g.production_quantity IS NULL THEN 0 ELSE 1 END AS 依頼中判定 FROM t_incoming_orders AS a INNER JOIN t_placing_orders AS b ON b.management_no = a.management_no AND b.final_process_type = true INNER JOIN ( SELECT management_no, process_sort_no, MAX(partial_delivery_no) AS partial_delivery_no FROM t_process_acceptances GROUP BY management_no, process_sort_no ) AS c ON c.management_no = b.management_no AND c.process_sort_no = b.process_sort_no INNER JOIN t_process_acceptances AS d ON d.management_no = c.management_no AND d.process_sort_no = c.process_sort_no AND d.partial_delivery_no = c.partial_delivery_no LEFT OUTER JOIN ( SELECT management_no, MAX(partial_delivery_no) AS partial_delivery_no FROM t_test_and_ship_requests GROUP BY management_no ) AS f ON f.management_no = a.management_no LEFT OUTER JOIN ( SELECT management_no, partial_delivery_no, production_quantity FROM t_test_and_ship_requests WHERE test_type = false OR (test_type = true AND test_result_type = '0') ) AS g ON g.management_no = f.management_no AND g.partial_delivery_no = f.partial_delivery_no LEFT OUTER JOIN m_suppliers AS e ON e.supplier_code = b.supplier_code WHERE a.incoming_order_type IN ('1','4') AND a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?) AND a.branch_no = ?

