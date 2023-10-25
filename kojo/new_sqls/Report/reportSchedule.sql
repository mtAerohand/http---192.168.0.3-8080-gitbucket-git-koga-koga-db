SCHEDULE =
SELECT
  K.supplier_code, SA.supplier_name漢字, K.machine_code, KI.machine_name, KI.machine_manager_code, TA.machine_manager_name,
  CASE RTRIM(K.branch_no) WHEN '' THEN K.incoming_order_no ELSE K.incoming_order_no || ' (' || K.branch_no || ')' END AS 表示incoming_order_no,
  CASE RTRIM(K.engineering_change_no) WHEN '' THEN K.part_no WHEN '0' THEN K.part_no WHEN '00' THEN K.part_no ELSE K.part_no || ' (' || K.engineering_change_no || ')' END AS 表示part_no,
  K.part_name, K.manufacture_quantity, K.deadline, CAST(JU.response_DATE as DATE), K.plan_start_DATE, K.plan_end_DATE
FROM m_process_plans AS K
INNER JOIN V_工場作業区ALL AS SA
ON SA.supplier_code = K.supplier_code
INNER JOIN m_machines AS KI
ON KI.supplier_code = K.supplier_code AND KI.machine_code = K.machine_code
LEFT OUTER JOIN
(
  SELECT placing_order_no, MIN(response_DATE) AS response_DATE
  FROM V_工場受注情報
  WHERE response_DATE <> ''
  GROUP BY placing_order_no
) AS JU
ON JU.placing_order_no = K.placing_order_no
LEFT OUTER JOIN m_machine_managers AS TA
ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code
WHERE K.supplier_code = ? AND K.machine_code = ? AND CAST(? as DATE) <= K.plan_start_DATE
ORDER BY K.plan_start_DATE;
