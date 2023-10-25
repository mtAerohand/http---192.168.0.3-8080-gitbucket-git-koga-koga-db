-- SQL_GET_GROUP
SELECT employee_code ,employee_name FROM m_employees WHERE type = '1' AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,employee_code
