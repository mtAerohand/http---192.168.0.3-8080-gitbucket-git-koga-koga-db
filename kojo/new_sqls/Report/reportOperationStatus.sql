SQL_OPERATION_STATUS =
SELECT
     DT.work_DATE
   , MK.supplier_code
   , MS.supplier_name
   , MK.machine_manager_code
   , COALESCE(MT.machine_manager_name, '') AS machine_manager_name
   , MK.machine_code
   , MK.machine_name
   , MK.sort_no
   , COALESCE(HS.incoming_order_no, '停止') AS incoming_order_no
   , HS.branch_no
   , HS.part_no
   , HS.engineering_change_no
   , HS.part_name
   , HS.manufacture_cost
   , HS.production_quantity
   , HS.error_quantity
   , HS.TACT
   , HS.出来高
   , HS.運転時間
   , HS.remarks 
 FROM (
   SELECT
     CAST(G AS DATE) AS work_DATE 
   FROM GENERATE_SERIES(CAST(? AS DATE), CAST(? AS DATE), '1 days') AS G
 ) AS DT 
 INNER JOIN m_machines AS MK 
   ON DT.work_DATE BETWEEN MK.valid_start_DATE AND MK.valid_end_DATE 
 INNER JOIN 本社DB.m_suppliers AS MS 
   ON MK.supplier_code = MS.supplier_code 
 LEFT OUTER JOIN m_machine_managers AS MT 
   ON MK.supplier_code = MT.supplier_code AND MK.machine_manager_code = MT.machine_manager_code 
 LEFT OUTER JOIN ( 
   SELECT
       KK.supplier_code
     , KK.machine_code
     , KK.incoming_order_no
     , KK.branch_no
     , KK.part_no
     , KK.engineering_change_no
     , KK.part_name
     , SS.manufacture_cost
     , KJ.work_DATE
     , KJ.manufacture_quantity AS production_quantity
     , KJ.error_quantity
     , KS.manufacture_seconds_per_unit AS TACT
     , SS.manufacture_cost * (KJ.manufacture_quantity - KJ.error_quantity) AS 出来高
     , CAST((KJ.manufacture_quantity * KS.manufacture_seconds_per_unit) / 3600 AS NUMERIC(4, 1)) AS 運転時間
     , KJ.remarks 
   FROM m_process_plans AS KK 
   INNER JOIN m_process_plan_details AS KS 
     ON KK.plan_no = KS.plan_no 
   INNER JOIN m_manufacture_results AS KJ 
     ON KS.plan_no = KJ.plan_no AND KS.process_no = KJ.process_no AND KJ.work_DATE  BETWEEN CAST(? AS DATE) AND CAST(? AS DATE) 
   LEFT OUTER JOIN 本社DB.t_incoming_orders AS JC 
     ON KK.incoming_order_no = JC.incoming_order_no AND KK.branch_no = JC.branch_no 
   INNER JOIN 本社DB.t_placing_orders AS HC 
     ON JC.management_no = HC.management_no AND KK.supplier_code = HC.supplier_code 
   INNER JOIN 本社DB.t_production_plans AS SK 
     ON HC.management_no = SK.management_no 
   INNER JOIN 本社DB.t_production_plan_details AS SS 
     ON HC.management_no = SS.management_no AND HC.process_sort_no = SS.process_sort_no
 ) AS HS 
   ON MK.supplier_code = HS.supplier_code 
   AND MK.machine_code = HS.machine_code 
   AND DT.work_DATE = HS.work_DATE ;

SQL_OPERATION_STATUS_WORK_REGION_CODE =  MK.supplier_code = ?;

SQL_OPERATION_STATUS_MACHINE_CODE =  MK.machine_code = ?;

SQL_OPERATION_STATUS_ORDER = ORDER BY DT.work_DATE, MK.supplier_code, MK.sort_no, HS.incoming_order_no, HS.branch_no;

