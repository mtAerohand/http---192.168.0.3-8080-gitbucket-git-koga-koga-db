-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.seq_no) AS INT) FROM t_acceptance_returns AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no INNER JOIN t_production_plan_details AS c ON c.management_no = a.management_no AND c.process_sort_no = a.process_sort_no INNER JOIN t_placing_orders AS d ON d.management_no = a.management_no AND d.process_sort_no = a.process_sort_no LEFT OUTER JOIN m_suppliers AS e ON e.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS f ON f.process_code = c.process_code
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.return_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_HENPINSAKI
AND a.supplier_code = ?


