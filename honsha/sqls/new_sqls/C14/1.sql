-- SQL_GET
SELECT supplier_code, supplier_name, supplier_abbreviation, zip_code_1, zip_code_2, address_1, address_2, type, supplier_type, acceptance_report_type, demand_contact_method_type, payment_method_type FROM m_suppliers WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE AND supplier_code = ?


