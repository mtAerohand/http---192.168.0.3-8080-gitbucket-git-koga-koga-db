-- SQL_GET_REPORT
SELECT a.seq_no ,a.customer_code ,COALESCE(b.zip_code_1,'') AS zip_code_1 ,COALESCE(b.zip_code_2,'') AS zip_code_2 ,COALESCE(b.address_1,'') AS address_1 ,COALESCE(b.address_2,'') AS address_2 ,COALESCE(b.customer_name,'') AS customer_name ,a.return_DATE ,a.part_no ,a.engineering_change_no ,c.part_name ,a.quantity ,a.unit_price ,- a.price AS price ,a.remarks FROM t_sales_returns AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no WHERE a.seq_no = ?


