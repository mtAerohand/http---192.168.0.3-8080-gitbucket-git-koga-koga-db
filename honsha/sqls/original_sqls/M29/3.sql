-- SQL_GET
SELECT a.品番 ,b.最新設変番号 ,b.品名 ,a.材質コード ,COALESCE(c.材質名, '') AS 材質名 ,a.梱包方法 ,a.梱包時注意事項 ,a.客先クレーム履歴 ,a.バージョン番号 FROM M_梱包 AS a INNER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?


