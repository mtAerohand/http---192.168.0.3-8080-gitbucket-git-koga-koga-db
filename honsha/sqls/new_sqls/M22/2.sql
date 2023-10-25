-- SQL_GET_ALL
SELECT material_shape_code,material_shape_name,has_shape_increase_rate,shape_increase_rate,sort_no,valid_start_DATE,valid_end_DATE FROM m_material_shapes
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE material_shape_name LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,material_shape_code
