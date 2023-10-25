GET_ALL_LIST =
SELECT supplier_code,machine_manager_code,machine_manager_name
FROM m_machine_managers
WHERE supplier_code = ?
ORDER BY machine_manager_code;
