-- SQL_GET_ALL
SELECT employee_code,employee_name,mail FROM m_employees WHERE department = '1' AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,employee_code


