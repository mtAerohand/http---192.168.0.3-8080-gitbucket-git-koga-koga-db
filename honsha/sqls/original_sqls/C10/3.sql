-- SQL_GET
SELECT a.品番 ,a.品名 ,a.最新設変番号 AS 設変番号 ,a.材料費変動補正対象 ,a.材質コード ,a.材質ベース単価 ,a.材料費 ,a.材料費補正額 ,a.材料径 ,a.製品長 ,a.材料形状コード ,a.得意先コード ,CASE WHEN b.SeqNo IS NULL THEN '' ELSE '管理図面' END AS 図面分類 FROM M_部品 AS a LEFT OUTER JOIN T_図面 AS b ON b.品番 = a.品番 AND b.図面種類 = '1'
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?
-- SQL_GET_LIMIT
LIMIT 1