GET_PLAN_LIST =
SELECT
 K.plan_no
 ,K.supplier_code
 ,K.machine_code
 ,KI.machine_name
 ,COALESCE(KI.machine_manager_code, '0') AS machine_manager_code
 ,TA.machine_manager_name
 ,CASE RTRIM(K.branch_no) WHEN '' THEN K.incoming_order_no ELSE K.incoming_order_no || ' (' || K.branch_no || ')' END AS 表示incoming_order_no
 ,K.placing_order_no
 ,CASE RTRIM(K.engineering_change_no) WHEN '' THEN K.part_no WHEN '0' THEN K.part_no WHEN '00' THEN K.part_no ELSE K.part_no || ' (' || K.engineering_change_no || ')' END AS 表示part_no
 ,COALESCE(K.part_name,'') AS part_name
 ,COALESCE(K.process_abbreviation,'') AS process_abbreviation
 ,K.deadline
 ,K.manufacture_quantity
 ,COALESCE(K.remarks,'') AS remarks
 ,K.plan_start_DATE
 ,K.plan_end_DATE
 ,KS.セット有無区分
 ,COALESCE(JU.response_DATE, '') AS response_DATE
 ,CASE WHEN JU2.placing_order_no IS NULL THEN '1' ELSE '0' END AS 受注取消区分
 ,CASE WHEN JU2.納品形態 = '1' THEN '1' WHEN JU2.納品形態 = '2' THEN '1' WHEN KJ.plan_no IS NOT NULL THEN '2' ELSE '3' END AS 作業状況
FROM m_process_plans AS K
INNER JOIN m_machines AS KI
ON KI.supplier_code = K.supplier_code AND KI.machine_code = K.machine_code
INNER JOIN (
    SELECT
    KS1.plan_no
    ,CASE WHEN KS2.has_set_time = true THEN '1' ELSE '0' END AS セット有無区分
    FROM (
        SELECT
        plan_no
        ,MIN(process_no) AS process_no
        FROM m_process_plan_details
        GROUP BY plan_no
    ) AS KS1
    INNER JOIN m_process_plan_details AS KS2
    ON KS1.plan_no = KS2.plan_no AND KS1.process_no = KS2.process_no
) AS KS
ON KS.plan_no = K.plan_no
LEFT OUTER JOIN (
    SELECT
    placing_order_no
    ,MIN(response_DATE) AS response_DATE
    FROM V_工場受注情報
    WHERE response_DATE IS NOT NULL
    AND response_DATE <> ''
    GROUP BY placing_order_no
) AS JU
ON JU.placing_order_no = K.placing_order_no
LEFT OUTER JOIN (
    SELECT DISTINCT
    placing_order_no
    ,納品形態
    FROM V_工場受注情報
) AS JU2
ON JU2.placing_order_no = K.placing_order_no
LEFT OUTER JOIN (
    SELECT DISTINCT
    plan_no
    FROM m_manufacture_results
) AS KJ
ON K.plan_no = KJ.plan_no
LEFT OUTER JOIN m_machine_managers AS TA
ON KI.supplier_code = TA.supplier_code AND KI.machine_manager_code = TA.machine_manager_code;
