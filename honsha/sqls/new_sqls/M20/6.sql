-- SQL_GET_ALL_COUNT_BY_WCODE
SELECT CAST(COUNT(biller) AS INT) FROM m_delivery_buckets WHERE biller = ? AND next_process_code = ?


