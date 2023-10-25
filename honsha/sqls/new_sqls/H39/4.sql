-- SQL_GET_SELECT
SELECT a.seq_no ,LEFT(a.inventory_month,4) AS 棚卸年 ,RIGHT(a.inventory_month,2) AS inventory_month ,a.supplier_code ,COALESCE(b.supplier_name,'') AS supplier_name ,a.type ,a.part_no ,a.engineering_change_no ,COALESCE(c.part_name,'') AS part_name ,a.quantity ,a.assessment_rate ,a.assessment_unit_price ,a.material_name ,a.shape ,a.weight ,a.unit_price ,a.price ,a.version_no FROM t_inventories AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no WHERE a.seq_no = CAST(? AS INT)


