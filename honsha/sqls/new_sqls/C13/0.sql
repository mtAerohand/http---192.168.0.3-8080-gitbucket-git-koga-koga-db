-- SQL_GET_ALL
SELECT supplier_code,supplier_name,supplier_abbreviation,payment_method_type FROM m_suppliers WHERE type = '1' AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,supplier_code


