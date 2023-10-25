-- SQL_GET
SELECT material_code ,material_name ,specific_gravity FROM m_materials WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE AND material_code = ?
