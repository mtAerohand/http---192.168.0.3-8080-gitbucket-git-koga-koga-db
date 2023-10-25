-- SQL_GET_ALL
SELECT customer_code,next_process_code,next_process_name,sort_no,valid_start_DATE,valid_end_DATE FROM m_next_processes
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE customer_code = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,next_process_code
