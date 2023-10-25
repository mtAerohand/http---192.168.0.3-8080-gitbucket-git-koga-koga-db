-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.品番) AS INT) FROM M_梱包 a
-- SQL_GET_ALL
SELECT a.品番 ,b.最新設変番号 ,b.品名 ,COALESCE(c.材質名, '') AS 材質名 ,a.梱包方法 ,a.梱包時注意事項 ,a.客先クレーム履歴 FROM M_梱包 AS a INNER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE a.品番 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.品番
-- SQL_MULTIPLE
SELECT CAST(a.値 as INT) FROM M_パラメータ a WHERE a.Key1 = CAST(? AS INT) AND a.Key2 = ? AND a.Key3 = ?
-- SQL_GET
SELECT a.品番 ,b.最新設変番号 ,b.品名 ,a.材質コード ,COALESCE(c.材質名, '') AS 材質名 ,a.梱包方法 ,a.梱包時注意事項 ,a.客先クレーム履歴 ,a.バージョン番号 FROM M_梱包 AS a INNER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?
-- SQL_CHECK_FOR_DUPLICATE_PACKING
SELECT CAST(COUNT(品番) AS INT) FROM M_梱包 WHERE 品番 = ?

