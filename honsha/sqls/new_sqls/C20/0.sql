-- SQL_GET_ALL
SELECT material_code,material_name,specific_gravity FROM m_materials WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE ORDER BY sort_no,material_code


