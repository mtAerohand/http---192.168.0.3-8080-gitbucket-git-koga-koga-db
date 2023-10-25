-- SQL_GET_ALL
SELECT a.supplier_code,b.supplier_name,a.manager_code,a.manager_name,a.mail FROM m_supplier_managers AS a INNER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.supplier_code
-- コードによる挿入部分
IN (?)
-- SQL_AFTER_IN_CLAUSE
AND CURRENT_DATE BETWEEN a.valid_start_DATE AND a.valid_end_DATE ORDER BY b.sort_no,a.supplier_code,a.sort_no,a.manager_code
