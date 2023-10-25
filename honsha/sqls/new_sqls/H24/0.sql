-- SQL_GETALL_SELECT
SELECT a.seq_no ,a.customer_code ,COALESCE(b.customer_abbreviation,'') AS customer_abbreviation ,a.part_no ,a.engineering_change_no ,a.quantity ,a.unit_price ,a.price ,a.return_DATE ,a.remarks FROM t_sales_returns AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.return_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_ORDERBY
ORDER BY a.return_DATE DESC, a.part_no, a.engineering_change_no


