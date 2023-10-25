-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(品番) AS INT) FROM M_部品
-- SQL_GET_ALL
SELECT 品番 ,最新設変番号 ,品名 FROM M_部品
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 品番 &^ ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 品番
-- SQL_GET_ALL_LIMIT
LIMIT ?
-- SQL_MULTIPLE
SELECT CAST(値 AS INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GET
SELECT a.品番 ,a.品名 ,a.最新設変番号 AS 設変番号 ,a.材料費変動補正対象 ,a.材質コード ,a.材質ベース単価 ,a.材料費 ,a.材料費補正額 ,a.材料径 ,a.製品長 ,a.材料形状コード ,a.得意先コード ,CASE WHEN b.SeqNo IS NULL THEN '' ELSE '管理図面' END AS 図面分類 FROM M_部品 AS a LEFT OUTER JOIN T_図面 AS b ON b.品番 = a.品番 AND b.図面種類 = '1'
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?
-- SQL_GET_LIMIT
LIMIT 1
-- SQL_GET_WITH_MATERIAL
SELECT a.品番 ,a.品名 ,a.最新設変番号 AS 設変番号 ,a.材料費変動補正対象 ,a.材質コード ,a.材質ベース単価 ,a.材料費 ,a.材料費補正額 ,a.材料径 ,a.製品長 ,a.材料形状コード ,a.得意先コード ,b.材質名 ,b.比重 FROM M_部品 AS a LEFT OUTER JOIN M_材質 AS b ON b.材質コード = a.材質コード

