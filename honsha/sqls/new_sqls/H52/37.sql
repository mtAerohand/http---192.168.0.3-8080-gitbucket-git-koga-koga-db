-- SQL_REPORT_23_COUNT_TEMPLATE
SELECT CAST(COUNT(c.supplier_code) AS INT) %s %s
    -- SQL_REPORT_23_COMMON
    FROM t_deadline_response_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no INNER JOIN t_production_plan_details AS c ON c.management_no = a.management_no AND c.process_sort_no = a.process_sort_no LEFT OUTER JOIN m_suppliers AS d ON d.supplier_code = c.supplier_code LEFT OUTER JOIN m_processes AS e ON e.process_code = c.process_code WHERE a.response_DATE IS NOT NULL AND a.response_DATE = CAST(? as DATE) AND EXISTS (SELECT * FROM t_placing_orders WHERE management_no = a.management_no AND process_sort_no = a.process_sort_no) AND NOT EXISTS (SELECT * FROM t_process_acceptances WHERE management_no = a.management_no AND process_sort_no = a.process_sort_no AND partial_delivery_no = a.partial_delivery_no)
    -- SQL_REPORT_23_ORDERBY
    ORDER BY COALESCE(d.sort_no,0), c.supplier_code, b.part_no


