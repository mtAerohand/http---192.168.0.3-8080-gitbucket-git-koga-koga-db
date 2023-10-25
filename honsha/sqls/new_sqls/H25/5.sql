-- SQL_GETALL_COUNT
SELECT CAST(COUNT(seq_no) AS INT) FROM t_sales_options AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.deal_code LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.deal_code
-- SQL_GETALL_WHERE
WHERE a.deal_type = ? AND a.sales_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_CODE
AND a.deal_code = ?


