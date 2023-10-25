GET_BY_PLAN_NUM_AND_WORK_DATE =
SELECT 計画NO, 工程NO, 作業日, 加工数, 不良数, COALESCE(備考, '') AS 備考, バージョン番号 
FROM T_加工実績 
WHERE 計画NO = CAST(? as INT) AND 工程NO = CAST(? as INT) 
AND 作業日 = CAST(? as DATE);