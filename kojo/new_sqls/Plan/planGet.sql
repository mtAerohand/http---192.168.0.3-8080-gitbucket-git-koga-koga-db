PLAN_GET =
SELECT K.plan_no, K.supplier_code, SA.supplier_name漢字, K.machine_code, KI.machine_name, COALESCE(KI.machine_manager_code, '0') AS machine_manager_code, TA.machine_manager_name, K.incoming_order_no, K.branch_no, K.placing_order_no, K.part_no,
K.engineering_change_no, COALESCE(K.part_name, '') AS part_name, K.deadline, K.incoming_order_quantity, K.manufacture_quantity, COALESCE(K.remarks, '') AS remarks,
K.operate_time, K.calculation_type, K.plan_start_DATE, K.plan_end_DATE, K.version_no,
COALESCE((SELECT MIN(response_DATE) FROM V_工場受注情報 WHERE placing_order_no = K.placing_order_no AND response_DATE <> ''),'') AS response_DATE,
KS.process_no, KS.final_process_type, KS.has_set_time, KS.set_time,
KS.manufacture_seconds_per_unit, KS.coefficient, KS.manufacture_total_time, KS.set_days, KS.manufacture_quantity_per_day, KS.manufacture_days,
KS.set_start_DATE, KS.set_start_time, KS.manufacture_start_DATE, KS.manufacture_start_time, KS.end_DATE, KS.end_time, KS.version_no
FROM m_process_plans AS K
INNER JOIN V_工場作業区ALL AS SA
ON SA.supplier_code = K.supplier_code
INNER JOIN m_machines AS KI
ON KI.supplier_code = K.supplier_code AND KI.machine_code = K.machine_code
INNER JOIN m_process_plan_details AS KS
ON KS.plan_no = K.plan_no
LEFT OUTER JOIN m_machine_managers AS TA
ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code
WHERE K.plan_no = CAST(? as INT)
ORDER BY KS.process_no;
