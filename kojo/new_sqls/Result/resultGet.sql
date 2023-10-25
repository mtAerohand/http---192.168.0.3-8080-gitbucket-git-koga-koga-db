GET_BY_PLAN_NUM_AND_WORK_DATE =
SELECT plan_no, process_no, work_DATE, manufacture_quantity, error_quantity, COALESCE(remarks, '') AS remarks, version_no 
FROM m_manufacture_results 
WHERE plan_no = CAST(? as INT) AND process_no = CAST(? as INT) 
AND work_DATE = CAST(? as DATE);
