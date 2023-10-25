-- SQL_GET
SELECT a.material_code,a.material_name,b.seq_no,b.apply_start_DATE,b.apply_end_DATE,b.material_basic_unit_price,b.remarks,b.version_no FROM m_materials AS a LEFT OUTER JOIN m_material_basic_unit_prices AS b ON b.material_code = a.material_code WHERE a.material_code = ? ORDER BY b.apply_start_DATE


