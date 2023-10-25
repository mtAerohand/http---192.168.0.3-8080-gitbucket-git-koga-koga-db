-- SQL_GET_PURCHASE
SELECT a.placing_order_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,b.part_name ,a.supplier_code ,COALESCE(d.supplier_name,'') AS supplier_name ,a.process_code ,COALESCE(e.process_name,'') AS process_name ,a.placing_order_DATE ,a.deadline ,a.placing_order_quantity ,a.placing_order_quantity - COALESCE(c.acceptance_quantity,0) AS 発注残数 FROM t_placing_orders AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN ( SELECT placing_order_no ,SUM(acceptance_quantity) AS acceptance_quantity FROM t_process_acceptances GROUP BY placing_order_no ) AS c ON c.placing_order_no = a.placing_order_no LEFT OUTER JOIN m_suppliers AS d ON d.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS e ON e.process_code = a.process_code
-- SQL_GET_PURCHASE_WHERE_CLAUSE_CHECK_NO
WHERE a.placing_order_no = CAST(? AS INT)


