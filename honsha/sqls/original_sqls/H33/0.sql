-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(z.得意先担当者名) AS INT) FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.得意先担当者名 ,a.件数 ,a.担当者コード ,COALESCE(社員名,'') AS 担当者名 ,b.表示順 FROM ( SELECT y.得意先コード ,x.得意先担当者名 ,x.担当者コード ,CAST(COUNT(x.管理No) AS INT) AS 件数 FROM T_納期回答 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No WHERE x.FAX作成 = true GROUP BY y.得意先コード, x.得意先担当者名, X.担当者コード ) AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード) as z WHERE z.担当者コード = ?


