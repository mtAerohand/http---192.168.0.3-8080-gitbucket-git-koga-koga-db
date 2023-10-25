-- SQL_GETALL_SELECT
SELECT a.seq_no ,a.deal_code ,CASE WHEN a.deal_type = '1' THEN COALESCE(b.customer_abbreviation,'') ELSE COALESCE(c.supplier_abbreviation,'') END AS 取引先名 ,a.part_no ,a.engineering_change_no ,a.part_name ,a.quantity ,a.unit_price ,a.price ,a.sales_DATE FROM t_sales_options AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.deal_code LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.deal_code
-- SQL_GETALL_WHERE
WHERE a.deal_type = ? AND a.sales_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_CODE
AND a.deal_code = ?
-- SQL_GETALL_ORDERBY
ORDER BY a.sales_DATE DESC, a.part_no, a.engineering_change_no


