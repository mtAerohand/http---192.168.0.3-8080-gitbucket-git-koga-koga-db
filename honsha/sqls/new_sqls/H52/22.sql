-- SQL_REPORT_COUNT
SELECT CAST(COUNT(a.management_no) AS INT)
-- SQL_REPORT_11_CORE
FROM t_incoming_orders AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code WHERE a.incoming_order_type IN ('2','3')
    -- SQL_REPORT_TOKUISAKI
    AND a.customer_code = ?
    -- SQL_REPORT_ZYUCHUUBI
    AND a.incoming_order_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_NOUKI
    AND a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_HINBAN
    AND a.part_no &^ ?
    -- SQL_REPORT_11_ORDER_BY
    ORDER BY COALESCE(b.sort_no,0), a.customer_code, a.part_no, a.incoming_order_DATE


