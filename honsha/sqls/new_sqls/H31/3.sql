-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.payment_month) AS INT) FROM t_payments AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.payment_month = ?


