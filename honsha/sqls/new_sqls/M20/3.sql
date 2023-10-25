-- SQL_GET_ALL_COUNT_BY_BILLING
SELECT CAST(COUNT(biller) AS INT) FROM m_delivery_buckets WHERE biller = ?


