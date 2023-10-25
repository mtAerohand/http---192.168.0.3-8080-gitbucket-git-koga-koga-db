-- SQL_GET_WITH_MATERIAL
SELECT a.品番 ,a.品名 ,a.最新設変番号 AS 設変番号 ,a.材料費変動補正対象 ,a.材質コード ,a.材質ベース単価 ,a.材料費 ,a.材料費補正額 ,a.材料径 ,a.製品長 ,a.材料形状コード ,a.得意先コード ,b.材質名 ,b.比重 FROM M_部品 AS a LEFT OUTER JOIN M_材質 AS b ON b.材質コード = a.材質コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?
-- SQL_GET_LIMIT
LIMIT 1
