SQL_RESULTLIST =
SELECT * FROM ( 
SELECT CASE RTRIM(b.branch_no) 
          WHEN '' THEN b.incoming_order_no 
          ELSE b.incoming_order_no || ' (' || RTRIM(b.branch_no) || ')' 
       END AS 表示incoming_order_no 
      ,TO_CHAR(b.incoming_order_quantity, 'FM99,999,999')  AS incoming_order_quantity 
      ,d.supplier_name漢字 
      ,c.machine_name 
      ,TO_CHAR(a.work_DATE,'YYYY/MM/DD') AS work_DATE 
      ,a.manufacture_quantity 
      ,a.error_quantity 
      ,CASE WHEN a.manufacture_quantity = 0 
         THEN 0 
         ELSE ROUND(CAST(a.error_quantity as NUMERIC) / a.manufacture_quantity * 100, 3) 
       END  AS 不良率 
      ,1 AS 区分 
      ,b.incoming_order_no 
      ,b.branch_no 
FROM m_manufacture_results AS a 
INNER JOIN m_process_plans AS b 
ON b.plan_no = a.plan_no 

INNER JOIN m_machines AS c 
ON c.supplier_code = b.supplier_code 
AND c.machine_code = b.machine_code 
AND a.work_DATE BETWEEN c.valid_start_DATE AND c.valid_end_DATE 

INNER JOIN V_工場作業区 AS d 
ON d.supplier_code = b.supplier_code 

WHERE a.work_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
AND b.part_no = ? ;

SQL_RESULTLIST_SETUHEN =
AND b.engineering_change_no = ? ;

SQL_RESULTLIST_UNION = 
UNION 
SELECT '' AS 表示incoming_order_no 
      ,'' AS incoming_order_quantity 
      ,'' AS supplier_name漢字 
      ,'' AS machine_name 
      ,'' AS work_DATE 
      ,x.manufacture_quantity計 
      ,x.error_quantity計 
      ,CASE WHEN x.manufacture_quantity計 = 0 
         THEN 0 
         ELSE ROUND(CAST(x.error_quantity計 as NUMERIC) / x.manufacture_quantity計 * 100, 3) 
       END  AS 不良率 
      ,2 AS 区分 
      ,x.incoming_order_no 
      ,x.branch_no 
FROM ( 
SELECT SUM(a.manufacture_quantity) AS manufacture_quantity計 
      ,SUM(a.error_quantity) AS error_quantity計 
      ,b.incoming_order_no 
      ,b.branch_no 
FROM m_manufacture_results AS a 
INNER JOIN m_process_plans AS b 
ON b.plan_no = a.plan_no 
WHERE a.work_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
AND b.part_no = ? ;

SQL_RESULTLIST_ORDER =
GROUP BY b.incoming_order_no, b.branch_no 
) AS x 
) AS y 
ORDER BY y.incoming_order_no, y.branch_no, y.区分, y.work_DATE, y.supplier_name漢字, y.machine_name;
