-- SQL_GET_SELECT
SELECT a.seq_no ,a.deal_type ,a.deal_code ,CASE WHEN a.deal_type = '1' THEN COALESCE(b.customer_name,'') ELSE COALESCE(c.supplier_name,'') END AS 取引先名 ,a.part_no ,a.engineering_change_no ,a.part_name ,a.quantity ,a.unit_price ,a.price ,a.sales_DATE ,a.remarks ,a.version_no FROM t_sales_options AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.deal_code LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.deal_code WHERE a.seq_no = CAST(? as INT)


