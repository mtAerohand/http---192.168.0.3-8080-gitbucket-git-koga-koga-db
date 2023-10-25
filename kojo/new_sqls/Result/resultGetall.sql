GET_ALL_FIRST =
SELECT work_DATE, prospected_manufacture_quantity AS manufacture_quantity, prospected_total_quantity AS 累計 
FROM m_manufacture_prospects 
WHERE plan_no = CAST(? as INT) 
AND process_no = CAST(? as INT) 
AND work_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
ORDER BY work_DATE;

GET_ALL_SECOND =
SELECT work_DATE, manufacture_quantity, error_quantity, (manufacture_quantity - error_quantity) AS 良品数, COALESCE(remarks, '') AS remarks 
FROM m_manufacture_results 
WHERE plan_no = CAST(? as INT) 
AND process_no = CAST(? as INT) 
AND work_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
ORDER BY work_DATE;
