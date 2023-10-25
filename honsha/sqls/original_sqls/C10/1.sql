-- p1: "1", p2: "C10", p3: ""
-- SQL_MULTIPLE
SELECT CAST(値 AS INT) FROM M_パラメータ WHERE Key1 = CAST(:p1 AS INT) AND Key2 = :p2 AND Key3 = :p3