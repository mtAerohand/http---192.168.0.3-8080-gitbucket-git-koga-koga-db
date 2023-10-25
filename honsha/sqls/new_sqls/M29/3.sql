-- SQL_GET
SELECT a.part_no ,b.latest_engineering_change_no ,b.part_name ,a.material_code ,COALESCE(c.material_name, '') AS material_name ,a.packing_method ,a.packing_caution ,a.customer_claim_history ,a.version_no FROM m_packings AS a INNER JOIN m_parts AS b ON b.part_no = a.part_no LEFT OUTER JOIN m_materials AS c ON c.material_code = a.material_code
-- SQL_GET_WHERE_CLAUSE
WHERE a.part_no = ?


