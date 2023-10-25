-- SQL_GET_ALL
SELECT supplier_code,supplier_name FROM m_suppliers WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,supplier_code


