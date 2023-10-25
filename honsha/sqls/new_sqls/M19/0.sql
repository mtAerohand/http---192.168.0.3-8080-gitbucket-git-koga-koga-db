-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(kogo) AS INT) FROM m_delivery_memos
    -- SQL_GET_ALL_WHERE_KOUGOU_CLAUSE
    WHERE kogo = ?
    
    -- SQL_GET_ALL_WHERE_ZUBAN_CLAUSE
    WHERE drawing_no LIKE ?


