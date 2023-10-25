-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.part_no) AS INT) FROM m_packings a
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE a.part_no LIKE ?


