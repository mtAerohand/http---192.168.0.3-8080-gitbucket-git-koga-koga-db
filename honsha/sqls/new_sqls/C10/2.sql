-- p1: parts_no, p2: recordCountLimit
-- SQL_GET_ALL
SELECT part_no ,latest_engineering_change_no ,part_name FROM m_parts
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE part_no &^ :p1
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY part_no
-- SQL_GET_ALL_LIMIT
LIMIT :p2
