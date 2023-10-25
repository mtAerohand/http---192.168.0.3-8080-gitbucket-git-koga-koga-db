-- SQL_EXISTS_SELECT_SONOTA
SELECT CASE WHEN EXISTS(SELECT * FROM t_purchases WHERE purchase_type = '2' AND purchase_category_type = '2' AND supplier_code = ? AND part_no = ? AND engineering_change_no = ? AND deal_DATE = ? %s) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入する/しない)
    AND seq_no <> CAST(? as INT)
