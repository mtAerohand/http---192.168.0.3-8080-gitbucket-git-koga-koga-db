GET_ALL_LIST =
SELECT KI.supplier_code,KI.machine_code,KI.machine_name,KI.machine_manager_code,TA.machine_manager_name,KI.sort_no,KI.valid_start_DATE,KI.valid_end_DATE 
FROM m_machines AS KI 
LEFT OUTER JOIN m_machine_managers AS TA ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code 
WHERE KI.supplier_code = ? 
ORDER BY KI.sort_no,KI.machine_code;
