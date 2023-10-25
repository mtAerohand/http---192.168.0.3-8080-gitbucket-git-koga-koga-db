-- SQL_GET_ALL
SELECT customer_code,delivery_place_code,delivery_place_name,sort_no,valid_start_DATE,valid_end_DATE FROM m_delivery_places
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE customer_code = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,delivery_place_code
