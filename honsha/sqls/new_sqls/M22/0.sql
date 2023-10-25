-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(material_shape_code) AS INT) FROM m_material_shapes
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE material_shape_name LIKE ?


