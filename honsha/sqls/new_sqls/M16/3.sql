-- SQL_GET_ALL
SELECT process_code,process_name,process_abbreviation,sort_no,valid_start_DATE,valid_end_DATE FROM m_processes
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE process_name LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,process_code


