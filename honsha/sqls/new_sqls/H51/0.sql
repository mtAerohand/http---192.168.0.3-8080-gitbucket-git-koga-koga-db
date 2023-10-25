-- SQL_PLACES
SELECT CASE WHEN EXISTS(SELECT * FROM t_material_price_calculations WHERE part_no = ? AND engineering_change_no = ?) THEN 1 ELSE 0 END AS 判定


