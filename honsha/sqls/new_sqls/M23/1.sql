-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.material_code) AS INT)
-- SQL_GET_ALL_FROM
FROM m_materials AS a LEFT OUTER JOIN ( SELECT material_code,MAX(apply_start_DATE) AS apply_start_DATE FROM m_material_basic_unit_prices GROUP BY material_code ) AS b ON b.material_code = a.material_code LEFT OUTER JOIN m_material_basic_unit_prices AS c ON c.material_code = b.material_code AND c.apply_start_DATE = b.apply_start_DATE WHERE CURRENT_DATE BETWEEN a.valid_start_DATE AND a.valid_end_DATE
    -- SQL_GET_ALL_WHERE_CLAUSE_MATERIAL_NAME
    AND a.material_name LIKE ?
    
    -- SQL_GET_ALL_WHERE_CLAUSE_BASE_PRICE
    AND c.apply_start_DATE IS NOT NULL


