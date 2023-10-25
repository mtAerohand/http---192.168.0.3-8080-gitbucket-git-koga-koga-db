-- SQL_GET_SELECT
SELECT a.payment_month ,a.supplier_code ,COALESCE(b.supplier_name,'') AS supplier_name ,a.payment_method_type ,a.price ,a.registration_DATE ,a.version_no FROM t_payments AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.payment_month = ? AND a.supplier_code = ?
