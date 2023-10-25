-- SQL_GETALL_COUNT
SELECT CAST(COUNT(seq_no) AS INT) FROM t_sales_returns AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.return_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)


