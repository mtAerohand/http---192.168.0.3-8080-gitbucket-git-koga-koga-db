SOMESQL = 
SELECT K.計画NO, K.工程NO, COALESCE(KY.予定加工数計, 0) AS 予定加工数計, COALESCE(KJ.実績加工数計, 0) AS 実績加工数計,
 COALESCE(KJ.不良数計, 0) AS 不良数計, COALESCE(良品数計, 0) AS 良品数計
 FROM T_工程計画詳細 AS K
 LEFT OUTER JOIN 
    (
    SELECT 計画NO, 工程NO, SUM(予定加工数) AS 予定加工数計
    FROM T_加工予定
    GROUP BY 計画NO, 工程NO
    ) AS KY
 ON KY.計画NO = K.計画NO AND KY.工程NO = K.工程NO
 LEFT OUTER JOIN
    (
    SELECT 計画NO, 工程NO, SUM(加工数) AS 実績加工数計, SUM(不良数) AS 不良数計, SUM(加工数) - SUM(不良数) AS 良品数計
    FROM T_加工実績
    GROUP BY 計画NO, 工程NO
    ) AS KJ
 ON KJ.計画NO = K.計画NO AND KJ.工程NO = K.工程NO
 WHERE K.計画NO = CAST(? as INT) AND K.工程NO = CAST(? as INT);

