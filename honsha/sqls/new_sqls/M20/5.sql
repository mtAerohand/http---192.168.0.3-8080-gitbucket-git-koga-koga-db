-- SQL_GET_ALL_COUNT_BY_PROCESS
SELECT CAST(COUNT(next_process_code) AS INT) FROM m_delivery_buckets WHERE next_process_code = ?


