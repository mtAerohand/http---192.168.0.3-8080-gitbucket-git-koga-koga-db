-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(customer_code) AS INT) FROM m_delivery_places
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE customer_code = ?


