RESULT_SHEET =
SELECT
  KI.supplier_code, SA.supplier_name漢字, KI.machine_code, KI.machine_name,
  CASE WHEN RTRIM(K.branch_no) IS NULL THEN '' WHEN RTRIM(K.branch_no) = '' THEN K.incoming_order_no ELSE K.incoming_order_no || ' (' || K.branch_no || ')' END AS 表示incoming_order_no,
  CASE WHEN RTRIM(K.engineering_change_no) IS NULL THEN '' WHEN RTRIM(K.engineering_change_no) = '' OR RTRIM(K.engineering_change_no) = '0' OR RTRIM(K.engineering_change_no) = '00' THEN K.part_no ELSE K.part_no || ' (' || K.engineering_change_no || ')' END AS 表示part_no
FROM m_machines AS KI
INNER JOIN V_工場作業区ALL AS SA
ON SA.supplier_code = KI.supplier_code
LEFT OUTER JOIN m_process_plans AS K
ON K.supplier_code = KI.supplier_code AND K.machine_code = KI.machine_code
AND CAST(? as DATE) BETWEEN K.plan_start_DATE AND K.plan_end_DATE
WHERE KI.supplier_code = ? AND CAST(? as DATE) BETWEEN  KI.valid_start_DATE AND KI.valid_end_DATE
ORDER BY KI.sort_no, 表示part_no;

