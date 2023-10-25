-- SQL_GETALL_SELECT
SELECT a.seq_no ,a.supplier_code ,COALESCE(e.supplier_abbreviation,'') AS supplier_name ,a.return_DATE ,a.management_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,a.process_sort_no ,c.process_code ,COALESCE(f.process_abbreviation,'') AS process_name ,d.placing_order_no ,a.quantity ,a.return_report_issue_DATE FROM t_acceptance_returns AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no INNER JOIN t_production_plan_details AS c ON c.management_no = a.management_no AND c.process_sort_no = a.process_sort_no INNER JOIN t_placing_orders AS d ON d.management_no = a.management_no AND d.process_sort_no = a.process_sort_no LEFT OUTER JOIN m_suppliers AS e ON e.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS f ON f.process_code = c.process_code
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.return_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GETALL_WHERE_HENPINSAKI
    AND a.supplier_code = ?
-- SQL_GETALL_ORDERBY
ORDER BY a.return_DATE DESC, b.incoming_order_no, b.branch_no, a.process_sort_no


