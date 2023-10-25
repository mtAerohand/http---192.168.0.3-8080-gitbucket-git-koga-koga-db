-- SQL_GET_ALL
SELECT customer_code,valid_start_DATE,valid_end_DATE,customer_name,zip_code_1,zip_code_2,address_1,address_2,sort_no FROM m_customers
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE customer_name LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,customer_code


