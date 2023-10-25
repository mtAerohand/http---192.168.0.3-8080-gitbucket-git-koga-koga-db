-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(z.得意先担当者名) AS INT) FROM (
-- SQL_GET_ALL
SELECT * FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.得意先担当者名 ,a.件数 ,a.担当者コード ,COALESCE(社員名,'') AS 担当者名 ,b.表示順 FROM ( SELECT y.得意先コード ,x.得意先担当者名 ,x.担当者コード ,CAST(COUNT(x.管理No) AS INT) AS 件数 FROM T_納期回答 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No WHERE x.FAX作成 = true GROUP BY y.得意先コード, x.得意先担当者名, X.担当者コード ) AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード) as z WHERE z.担当者コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY COALESCE(z.表示順,0), z.得意先コード, z.得意先担当者名
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_REPORT
SELECT a.管理No ,a.分納No ,b.受注番号 ,b.品番 ,b.設変番号 ,b.品名 ,a.予定納入数 ,a.回答日 ,a.FAX備考 ,a.バージョン番号 FROM T_納期回答 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.FAX作成 = true AND CAST(b.得意先コード AS INT) = ? AND CAST(a.担当者コード AS INT) = ? AND a.得意先担当者名 = ? ORDER BY a.回答日, b.受注番号

