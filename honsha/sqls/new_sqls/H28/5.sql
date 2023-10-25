-- SQL_GETPURCHASE_SELECT
SELECT a.placing_order_no ,a.management_no ,a.process_sort_no ,b.incoming_order_no ,b.branch_no ,a.supplier_code ,COALESCE(c.supplier_name,'') AS supplier_name ,a.process_code ,COALESCE(d.process_name,'') AS process_name ,a.placing_order_DATE ,a.deadline ,b.part_no ,b.engineering_change_no ,b.part_name ,a.placing_order_quantity ,a.unit_price ,CAST(trunc(a.unit_price * a.placing_order_quantity ,0) as BIGINT) AS 発注price FROM t_placing_orders AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS d ON d.process_code = a.process_code WHERE a.placing_order_no = CAST(? AS INT)


