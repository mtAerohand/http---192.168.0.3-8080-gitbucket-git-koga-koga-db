-- SQL_GET_SELECT
SELECT a.seq_no ,a.supplier_code ,COALESCE(b.supplier_name,'') AS 仕入先名 ,a.purchase_category_type ,a.material_name ,a.shape ,a.weight ,a.material_unit ,a.part_no ,a.engineering_change_no ,a.part_name ,a.quantity ,a.unit_price ,a.price ,a.supply_target_code ,COALESCE(c.supplier_name,'') AS 支給先名 ,a.supply_amount ,a.deal_DATE ,a.remarks ,a.version_no ,a.offset_method_type ,d.offset_DATE ,d.weight ,d.offset_amount FROM t_purchases AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.supply_target_code LEFT OUTER JOIN t_purchase_offsets AS d ON d.seq_no = a.seq_no WHERE a.seq_no = CAST(? AS INT) ORDER BY d.offset_seq_no


