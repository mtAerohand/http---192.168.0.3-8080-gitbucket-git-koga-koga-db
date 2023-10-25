SOMESQL = 
SELECT K.plan_no, K.process_no, COALESCE(KY.prospected_manufacture_quantity計, 0) AS prospected_manufacture_quantity計, COALESCE(KJ.実績manufacture_quantity計, 0) AS 実績manufacture_quantity計,
 COALESCE(KJ.error_quantity計, 0) AS error_quantity計, COALESCE(良品数計, 0) AS 良品数計
 FROM m_process_plan_details AS K
 LEFT OUTER JOIN 
    (
    SELECT plan_no, process_no, SUM(prospected_manufacture_quantity) AS prospected_manufacture_quantity計
    FROM m_manufacture_prospects
    GROUP BY plan_no, process_no
    ) AS KY
 ON KY.plan_no = K.plan_no AND KY.process_no = K.process_no
 LEFT OUTER JOIN
    (
    SELECT plan_no, process_no, SUM(manufacture_quantity) AS 実績manufacture_quantity計, SUM(error_quantity) AS error_quantity計, SUM(manufacture_quantity) - SUM(error_quantity) AS 良品数計
    FROM m_manufacture_results
    GROUP BY plan_no, process_no
    ) AS KJ
 ON KJ.plan_no = K.plan_no AND KJ.process_no = K.process_no
 WHERE K.plan_no = CAST(? as INT) AND K.process_no = CAST(? as INT);

