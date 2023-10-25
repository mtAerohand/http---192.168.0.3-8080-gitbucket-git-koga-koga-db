GET_BY_WORK_REGION_AND_START_AND_END_DATE =
SELECT KI.supplier_code,KI.machine_code,KI.machine_name,KI.machine_manager_code,TA.machine_manager_name 
FROM m_machines AS KI 
LEFT OUTER JOIN m_machine_managers AS TA ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code
WHERE KI.supplier_code = ? AND CAST(? as DATE) <= KI.valid_end_DATE AND KI.valid_start_DATE <= CAST(? as DATE) 
ORDER BY KI.sort_no,KI.machine_code;
