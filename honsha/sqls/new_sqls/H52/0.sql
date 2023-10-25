-- SQL_REPORT_21_COUNT_TEMPLATE
SELECT CAST(COUNT(a.supplier_code) AS INT) %s %s %s
-- SQL_REPORT_21_COMMON
FROM t_placing_orders AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS c ON c.process_code = a.process_code INNER JOIN t_incoming_orders AS d ON d.management_no = a.management_no LEFT OUTER JOIN ( SELECT placing_order_no ,SUM(acceptance_quantity) AS 総acceptance_quantity FROM t_process_acceptances GROUP BY placing_order_no ) AS e ON e.placing_order_no = a.placing_order_no LEFT OUTER JOIN m_customers AS f ON f.customer_code = d.customer_code LEFT OUTER JOIN ( SELECT management_no ,process_sort_no ,response_DATE ,requested_delivery_quantity FROM t_deadline_response_requests WHERE response_DATE IS NOT NULL ) AS g ON g.management_no = a.management_no AND g.process_sort_no = a.process_sort_no WHERE a.supplier_code = ? AND a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM t_process_acceptances WHERE placing_order_no = a.placing_order_no AND acceptance_form_type IN ('1','2'))
    -- SQL_REPORT_21_WHERE_TOKUISAKI(%s1)
    AND d.customer_code = ?
    -- SQL_REPORT_21_WHERE_HINBANI(%s2)
    AND d.part_no &^ ?
    -- SQL_REPORT_21_ORDERBY(%s3)
    ORDER BY d.part_no, a.deadline, g.response_DATE


