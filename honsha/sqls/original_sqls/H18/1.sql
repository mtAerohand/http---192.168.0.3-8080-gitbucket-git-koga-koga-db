-- SQL_GET_ALL_EDIT_SELECT
SELECT a.管理No ,a.分納No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.納期 ,b.受注数 ,a.依頼日 ,a.依頼数 ,b.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,CASE b.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS 受注区分 ,b.得意先コード ,COALESCE(d.得意先略称,'') AS 得意先名
-- SQL_GET_ALL_EDIT_FROM2
FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = b.得意先コード WHERE ((a.検査区分 = true AND a.検査結果区分 = '0') OR (a.検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)) )
-- 702
AND a.管理No = CAST(? AS INT)
-- 703
AND a.分納No = CAST(? AS INT)


