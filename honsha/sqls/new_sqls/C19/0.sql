-- SQL_GET_ALL
SELECT customer_code ,next_process_code ,next_process_name FROM m_next_processes WHERE customer_code = ? AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,next_process_code


