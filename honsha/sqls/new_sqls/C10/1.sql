-- p1: "1", p2: "C10", p3: ""
-- SQL_MULTIPLE
SELECT CAST(value AS INT) FROM m_parameters WHERE key_1 = CAST(:p1 AS INT) AND key_2 = :p2 AND key_3 = :p3
