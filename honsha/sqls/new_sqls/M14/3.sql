-- SQL_GET
SELECT a.supplier_code,b.supplier_name,a.manager_code,a.manager_name,a.mail,a.user_id,a.password,a.authority,a.sort_no,a.valid_start_DATE,a.valid_end_DATE,a.remarks,a.version_no FROM m_supplier_managers AS a INNER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.supplier_code = ? AND a.manager_code = ?


