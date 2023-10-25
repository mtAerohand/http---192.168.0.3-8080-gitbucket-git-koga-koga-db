-- SQL_GET_ALL
SELECT customer_code,delivery_place_code,delivery_place_name FROM m_delivery_places WHERE customer_code = ? AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,delivery_place_code


