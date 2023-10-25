GET_BY_WORK_REGION_ID_AND_MACHINE_ID =
SELECT KI.supplier_code,KI.machine_code,KI.machine_manager_code,TA.machine_manager_name,KI.valid_start_DATE,KI.valid_end_DATE,KI.machine_name,KI.sort_no,KI.remarks,KI.version_no
FROM m_machines AS KI
LEFT OUTER JOIN m_machine_managers AS TA ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code
WHERE KI.supplier_code = ? AND KI.machine_code = ?;

