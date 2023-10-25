GET_ALL_FIRST =
SELECT 作業日, 予定加工数 AS 加工数, 予定累計 AS 累計 
FROM T_加工予定 
WHERE 計画NO = CAST(? as INT) 
AND 工程NO = CAST(? as INT) 
AND 作業日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
ORDER BY 作業日;

GET_ALL_SECOND =
SELECT 作業日, 加工数, 不良数, (加工数 - 不良数) AS 良品数, COALESCE(備考, '') AS 備考 
FROM T_加工実績 
WHERE 計画NO = CAST(? as INT) 
AND 工程NO = CAST(? as INT) 
AND 作業日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
ORDER BY 作業日;