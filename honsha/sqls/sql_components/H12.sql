-- SQL_GET_PARAM
SELECT Key3, 値 FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ?
-- SQL_GET_BEFORE_ORDER
SELECT a.管理No ,a.梱包区分 ,CASE WHEN a.発注備考区分1 = false THEN a.発注備考1 ELSE '' END AS 発注備考1 ,CASE WHEN a.発注備考区分2 = false THEN a.発注備考2 ELSE '' END AS 発注備考2 ,CASE WHEN a.依頼備考区分1 = false THEN a.依頼備考1 ELSE '' END AS 依頼備考1 ,CASE WHEN a.依頼備考区分2 = false THEN a.依頼備考2 ELSE '' END AS 依頼備考2 ,a.テーパーおねじ区分 ,a.担当者コード ,a.検査表添付区分 FROM T_受注 AS a INNER JOIN ( SELECT 品番 ,MAX(受注日) AS 受注日 FROM T_受注 WHERE 受注区分 <> '4' GROUP BY 品番 ) AS b ON b.品番 = a.品番 AND b.受注日 = a.受注日 WHERE a.品番 = ? AND a.設変番号 = ? LIMIT 1
-- LOG_DIR
log

