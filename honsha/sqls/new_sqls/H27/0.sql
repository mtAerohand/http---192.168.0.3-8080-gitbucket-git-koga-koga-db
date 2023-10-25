-- SQL_GETALL_SELECT
SELECT a.seq_no ,a.supplier_code ,COALESCE(b.supplier_abbreviation,'') AS supplier_name ,CASE WHEN a.purchase_category_type = '1' THEN '材料' ELSE 'その他' END AS purchase_category_type ,a.deal_DATE AS return_DATE ,CASE WHEN a.purchase_category_type = '1' THEN a.material_name ELSE a.part_no END AS 材質part_no ,CASE WHEN a.purchase_category_type = '1' THEN '' ELSE a.engineering_change_no END AS engineering_change_no ,CASE WHEN a.purchase_category_type = '1' THEN a.shape ELSE a.part_name END AS shapepart_name ,a.weight ,a.quantity ,a.unit_price ,a.price FROM t_purchases AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.purchase_type = '2'
-- SQL_GETALL_WHERE_HENPINBI
AND a.deal_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GETALL_WHERE_HENPINSAKI
    AND a.supplier_code = ?
-- SQL_GETALL_ORDERBY
ORDER BY a.deal_DATE DESC, 材質part_no, a.engineering_change_no, shapepart_name


