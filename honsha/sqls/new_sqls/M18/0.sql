-- SQL_PLACES
SELECT CASE WHEN EXISTS(SELECT * FROM m_next_processes WHERE customer_code = ? AND next_process_code = ?) THEN 1 ELSE 0 END AS 判定


