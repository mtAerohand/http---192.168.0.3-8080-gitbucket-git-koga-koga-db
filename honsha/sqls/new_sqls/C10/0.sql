-- p1: parts_no
-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(part_no) AS INT) FROM m_parts
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE part_no &^ :p1
