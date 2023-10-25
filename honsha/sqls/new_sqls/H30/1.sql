-- SQL_GETALL_SELECT
SELECT a.payment_month, a.supplier_code, b.supplier_name , a.last_month_balance, a.payment_amount, a.sales_amount_count, a.sales_amount, a.sales_amount_tax , a.material_supply_amount_count, a.material_supply_amount, a.material_supply_amount_tax, a.billing_amount , b.payment_method_type AS 仕入先payment_method_type , CASE WHEN COALESCE(c.payment_method_type,b.payment_method_type) = '1' THEN '現金' WHEN COALESCE(c.payment_method_type,b.payment_method_type) = '2' THEN '手形' WHEN COALESCE(c.payment_method_type,b.payment_method_type) = '3' THEN 'その他' ELSE '' END AS payment_method_type , c.price , COALESCE(c.version_no, 0) AS version_no FROM t_acceptance_tests a LEFT OUTER JOIN m_suppliers b ON a.supplier_code = b.supplier_code LEFT OUTER JOIN t_payments AS c ON c.payment_month = a.payment_month AND c.supplier_code = a.supplier_code
-- SQL_GETALL_WHERE_PAYMENT_MONTH
WHERE a.payment_month = ?
-- SQL_GETALL_WHERE_SHIIRESAKI_CODE
AND a.supplier_code = ?
-- SQL_GETALL_ORDER
ORDER BY COALESCE(b.sort_no,0), a.supplier_code


