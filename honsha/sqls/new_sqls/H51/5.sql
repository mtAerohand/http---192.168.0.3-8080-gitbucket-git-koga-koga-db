-- SQL_PRICE
SELECT material_code,material_basic_unit_price FROM m_material_basic_unit_prices WHERE material_code = ? AND CURRENT_DATE BETWEEN apply_start_DATE AND apply_end_DATE


