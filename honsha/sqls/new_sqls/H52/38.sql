-- SQL_REPORT_24_COUNT_TEMPLATE
SELECT CAST(COUNT(a.supplier_code) AS INT) %s %s %s
-- SQL_REPORT_24_COMMON(%s1)
FROM t_placing_orders AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS c ON c.process_code = a.process_code INNER JOIN t_incoming_orders AS d ON d.management_no = a.management_no LEFT OUTER JOIN m_customers AS k ON k.customer_code = d.customer_code LEFT OUTER JOIN ( SELECT management_no ,process_sort_no ,MIN(partial_delivery_no) AS partial_delivery_no FROM t_deadline_response_requests WHERE response_DATE IS NOT NULL GROUP BY management_no, process_sort_no ) AS e ON e.management_no = a.management_no AND e.process_sort_no = a.process_sort_no LEFT OUTER JOIN t_deadline_response_requests AS f ON f.management_no = e.management_no AND f.process_sort_no = e.process_sort_no AND f.partial_delivery_no = e.partial_delivery_no LEFT OUTER JOIN ( SELECT placing_order_no ,MAX(partial_delivery_no) AS partial_delivery_no ,SUM(acceptance_quantity) AS acceptance_quantity FROM t_process_acceptances GROUP BY placing_order_no ) AS g ON g.placing_order_no = a.placing_order_no LEFT OUTER JOIN t_process_acceptances AS h ON h.placing_order_no = g.placing_order_no AND h.partial_delivery_no = g.partial_delivery_no LEFT OUTER JOIN t_production_plan_details AS i ON i.management_no = a.management_no AND i.process_sort_no = (a.process_sort_no + 1) LEFT OUTER JOIN m_suppliers AS j ON j.supplier_code = i.supplier_code WHERE a.placing_order_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_24_WHERE_SAGYOUKU(%s2)
    AND a.supplier_code = ?
    -- SQL_REPORT_24_WHERE_HINBANI(%s3)
    AND d.part_no &^ ?
    -- SQL_REPORT_24_ORDERBY(%s4)
    ORDER BY a.supplier_code, d.part_no, a.placing_order_DATE, a.deadline


