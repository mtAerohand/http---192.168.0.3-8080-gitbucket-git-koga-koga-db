-- SQL_GET_SELECT
SELECT a.seq_no ,a.customer_code ,COALESCE(b.customer_name,'') AS customer_name ,a.part_no ,a.engineering_change_no ,COALESCE(c.part_name,'') AS part_name ,a.quantity ,a.unit_price ,a.price ,a.return_DATE ,a.remarks ,a.version_no FROM t_sales_returns AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no WHERE a.seq_no = CAST(? AS INT)


