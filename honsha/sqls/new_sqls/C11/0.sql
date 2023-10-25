-- SQL_GET_ALL
SELECT customer_code, customer_name ,CASE WHEN customer_code = '1' THEN '1' ELSE '0' END as 得意先区分 FROM m_customers WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,customer_code


