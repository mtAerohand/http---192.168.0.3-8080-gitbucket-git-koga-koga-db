-- SQL_GET_ALL_VOID_EFFECTIVE_DATE
SELECT customer_code, customer_name, customer_abbreviation, zip_code_1, zip_code_2, address_1, address_2, closing_DATE_type, closing_DATE ,CASE WHEN customer_code = '1' THEN '1' ELSE '0' END as 得意先区分 FROM m_customers WHERE customer_code = ?


