-- SQL_GET
SELECT customer_code ,customer_name ,customer_abbreviation ,zip_code_1 ,zip_code_2 ,address_1 ,address_2 ,closing_DATE_type ,closing_DATE ,CASE WHEN customer_code = '1' THEN '1' ELSE '0' END as 得意先区分 FROM m_customers WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE AND customer_code = ?


