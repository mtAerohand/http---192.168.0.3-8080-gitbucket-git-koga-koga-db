﻿-- p1: parts_no
-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(品番) AS INT) FROM M_部品
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 品番 &^ :p1