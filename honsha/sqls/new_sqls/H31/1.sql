-- SQL_GETALL_SELECT
SELECT a.payment_month ,a.supplier_code ,COALESCE(b.supplier_name,'') AS supplier_name ,CASE WHEN a.payment_method_type = '1' THEN a.price ELSE 0 END AS 現金支払額 ,CASE WHEN a.payment_method_type = '2' THEN a.price ELSE 0 END AS 手形支払額 ,CASE WHEN a.payment_method_type = '3' THEN a.price ELSE 0 END AS その他支払額 ,a.registration_DATE FROM t_payments AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.payment_month = ?
-- SQL_GETALL_WHERE_CODE
AND a.supplier_code = ?


