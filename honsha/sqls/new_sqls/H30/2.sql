-- SQL_CREATE_REPORT_HEADER_SELECT
SELECT b.zip_code_1, b.zip_code_2, b.address_1, b.address_2, b.supplier_name , a.last_month_balance, a.payment_amount, a.sales_amount_count, a.sales_amount, a.sales_amount_tax , a.material_supply_amount_count, a.material_supply_amount, a.material_supply_amount_tax, a.billing_amount FROM t_acceptance_tests a LEFT OUTER JOIN m_suppliers b ON a.supplier_code = b.supplier_code
-- SQL_CREATE_REPORT_HEADER_WHERE
WHERE a.payment_month = ? AND a.supplier_code = ?


