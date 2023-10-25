PLAN_GET_RECORD =
SELECT K.supplier_code, K.machine_code, K.part_no, K.engineering_change_no, K.remarks, K.operate_time, K.calculation_type, KS2.process_no, KS2.final_process_type,
KS2.has_set_time, KS2.set_time, KS2.manufacture_seconds_per_unit, KS2.manufacture_quantity_per_day
FROM m_process_plans AS K
INNER JOIN (SELECT supplier_code, machine_code, part_no, MAX(plan_no) AS plan_no
            FROM m_process_plans
            WHERE supplier_code = ? AND machine_code = ? AND part_no = ?
            GROUP BY supplier_code, machine_code, part_no) AS K2
ON K2.plan_no = K.plan_no
INNER JOIN (SELECT K4.supplier_code, K4.machine_code, K4.part_no, K4.calculation_type, K4.process_no, MAX(K4.plan_no) AS plan_no
            FROM (
                SELECT K3.plan_no, K3.supplier_code, K3.machine_code, K3.part_no, K3.calculation_type, KS.process_no
                FROM m_process_plans AS K3
                INNER JOIN m_process_plan_details AS KS
                ON KS.plan_no = K3.plan_no
                WHERE supplier_code = ? AND machine_code = ? AND part_no = ?
            ) AS K4
            GROUP BY K4.supplier_code, K4.machine_code, K4.part_no, K4.calculation_type, K4.process_no) AS K5
ON K5.supplier_code = K.supplier_code AND K5.machine_code = K.machine_code AND K5.part_no = K.part_no AND K5.calculation_type = K.calculation_type
INNER JOIN m_process_plan_details AS KS2
ON KS2.plan_no = K5.plan_no AND KS2.process_no = K5.process_no
ORDER BY KS2.process_no;
