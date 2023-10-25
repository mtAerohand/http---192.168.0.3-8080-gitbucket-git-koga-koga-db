-- SQL_ADD_TANAOROSHI_EXISTS
SELECT CAST(COUNT(seq_no) AS INT) AS 件数 FROM t_inventories WHERE inventory_month = ? AND type = ? AND supplier_code = ? AND (CASE WHEN type = '1' THEN part_no ELSE material_name END) = ? AND (CASE WHEN type = '1' THEN engineering_change_no ELSE shape END) = ?


