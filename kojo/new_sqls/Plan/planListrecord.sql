GET_PLAN_LIST_RECORD =
SELECT K.supplier_code, K.part_no, COALESCE(K.part_name, ''), CASE RTRIM(K.branch_no) WHEN '' THEN K.incoming_order_no ELSE K.incoming_order_no || ' (' || K.branch_no || ')' END AS 表示incoming_order_no
 ,K.manufacture_quantity, K.engineering_change_no, COALESCE(K.process_abbreviation, ''), KI.machine_name, TA.machine_manager_name, KS.process_no, KS.set_time, KS.manufacture_seconds_per_unit, KS.manufacture_quantity_per_day
 ,CASE WHEN KS.has_set_time = true THEN KS.set_start_DATE ELSE KS.manufacture_start_DATE END AS plan_start_DATE,KS.end_DATE AS plan_end_DATE
FROM m_process_plans AS K
INNER JOIN m_process_plan_details AS KS ON KS.plan_no = K.plan_no
INNER JOIN m_machines AS KI ON KI.supplier_code = K.supplier_code AND KI.machine_code = K.machine_code
LEFT OUTER JOIN m_machine_managers AS TA ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code
WHERE K.supplier_code = ? AND K.part_no = ?
ORDER BY K.plan_start_DATE DESC, K.plan_no, KS.process_no;
