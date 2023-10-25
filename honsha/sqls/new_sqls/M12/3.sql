-- SQL_GET_ALL
SELECT customer_code,manager_code,manager_name,sort_no,valid_start_DATE,valid_end_DATE FROM m_customer_managers
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE customer_code = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,manager_code
