-- p1: parts_no, p2: recordCountLimit
-- SQL_GET_ALL
SELECT 品番 ,最新設変番号 ,品名 FROM M_部品
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 品番 &^ :p1
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 品番
-- SQL_GET_ALL_LIMIT
LIMIT :p2