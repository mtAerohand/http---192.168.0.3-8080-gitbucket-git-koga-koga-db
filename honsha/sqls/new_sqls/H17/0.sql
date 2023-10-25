-- SQL_GET_PROCESS
SELECT a.placing_order_no ,a.management_no ,a.process_sort_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,b.part_name ,a.supplier_code ,COALESCE(e.supplier_name,'') AS supplier_name ,a.process_code ,COALESCE(f.process_name,'') AS process_name ,a.placing_order_DATE ,a.deadline ,a.final_process_type ,COALESCE(d.受入件数,0) + 1 AS partial_delivery_no ,a.placing_order_quantity ,a.placing_order_quantity - COALESCE(d.総acceptance_quantity,0) AS 発注残数 ,a.unit_price ,CAST(TRUNC(a.unit_price * (a.placing_order_quantity - COALESCE(d.総acceptance_quantity, 0)), 0) AS BIGINT) AS price FROM t_placing_orders AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN ( SELECT placing_order_no ,COUNT(placing_order_no) AS 受入件数 ,SUM(acceptance_quantity) AS 総acceptance_quantity FROM t_process_acceptances GROUP BY placing_order_no ) AS d ON d.placing_order_no = a.placing_order_no LEFT OUTER JOIN m_suppliers AS e ON e.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS f ON f.process_code = a.process_code
-- SQL_GET_WHERE_CLAUSE_CHECK_NO
WHERE a.placing_order_no = CAST(? AS INT)


