-- SQL_REPORT_51_COUNT_TEMPLATE
SELECT CAST(COUNT(a.customer_code) AS INT) %s %s %s
-- SQL_REPORT_51_COMMON(%s1)
FROM t_drawings AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no LEFT OUTER JOIN t_drawing_details AS d ON d.seq_no = a.seq_no LEFT OUTER JOIN m_suppliers AS e ON e.supplier_code = d.supplier_code WHERE a.customer_code = ? AND a.notice_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_51_WHERE_HINBAN(%s2)
    AND a.part_no &^ ?
    -- SQL_REPORT_51_ORDERBY(%s3)
    ORDER BY a.part_no, a.engineering_change_no, a.notice_DATE, COALESCE(d.process_sort_no,0)


