-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.管理No) AS INT) FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.検査区分 = true AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)
-- SQL_WHERE_UNCHECK
AND a.検査結果区分 = '0'
-- SQL_WHERE_CHECK
AND a.検査結果区分 <> '0' AND a.結果登録日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_WHERE_ORDER
AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
-- SQL_WHERE_DIVID
AND a.管理No = CAST(? AS INT) AND a.分納No = CAST(? AS INT)
-- SQL_GET_ALL
SELECT a.管理No,a.分納No,a.検査結果区分,CASE a.検査結果区分 WHEN '0' THEN '' WHEN '1' THEN '合 格' WHEN '2' THEN '不合格' ELSE '' END 合否 ,b.受注番号,b.枝番 ,b.品番,b.設変番号,CASE b.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分,a.納入日 ,a.回答日,a.依頼日,a.結果登録日,a.依頼数,a.バージョン番号 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.検査区分 = true AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)
-- SQL_GET_DATA
SELECT a.管理No,a.分納No,b.受注番号,b.枝番,b.品番,b.設変番号,a.バージョン番号,依頼数 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.管理No = CAST(? AS INT) AND a.検査区分 = true AND a.検査結果区分 = '0'
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?

