-- SQL_GET_ALL
SELECT a.part_no, a.latest_engineering_change_no, a.part_name, b.material_name, a.material_basic_unit_price, a.material_cost, a.material_cost_correction_amount FROM m_parts a LEFT OUTER JOIN m_materials b ON a.material_code = b.material_code
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE a.part_no LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.part_no


