GET_BY_WORK_REGION_ID_AND_OPERATOR_ID =
SELECT supplier_code,machine_manager_code,machine_manager_name,version_no
FROM m_machine_managers
WHERE supplier_code = ? AND machine_manager_code = ?;
