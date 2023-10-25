-- SQL_GET_ALL
SELECT customer_code,manager_code,manager_name FROM m_customer_managers WHERE customer_code = ? AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,manager_code
