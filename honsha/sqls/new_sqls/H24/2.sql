-- SQL_GETALL_SELECT
SELECT a.seq_no ,a.customer_code ,COALESCE(b.customer_abbreviation,'') AS customer_abbreviation ,a.part_no ,a.engineering_change_no ,a.quantity ,a.unit_price ,a.price ,a.return_DATE ,a.remarks FROM t_sales_returns AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code
-- SQL_GETALL_WHERE_seq_no
WHERE a.seq_no = CAST(? AS INT)


