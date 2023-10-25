-- SQL_ADD_ZUMEN_EXISTS
SELECT CAST(COUNT(seq_no) AS INT) AS 件数 FROM t_drawings WHERE drawing_type = ? AND part_no = ? AND (CASE WHEN drawing_type = '1' THEN engineering_change_no ELSE new_engineering_change_no END) = ?
-- SQL_UPDATE_ZUMEN_EXISTS_WHERE
AND seq_no <> CAST(? as INT) --訂正の場合
