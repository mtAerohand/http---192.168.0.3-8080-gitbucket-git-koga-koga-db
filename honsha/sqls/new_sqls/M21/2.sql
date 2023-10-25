-- SQL_GET_ALL
SELECT material_code,material_name,specific_gravity,sort_no,valid_start_DATE,valid_end_DATE FROM m_materials
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE material_name LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,material_code
