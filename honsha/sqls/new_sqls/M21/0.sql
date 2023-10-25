-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(material_code) AS INT) FROM m_materials
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE material_name LIKE ?


