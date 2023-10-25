-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(customer_code) AS INT) FROM m_customers
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE customer_name LIKE ?

