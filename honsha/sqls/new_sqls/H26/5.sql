-- SQL_EXISTS_SELECT_ZAIRYOU
SELECT CASE WHEN EXISTS(SELECT * FROM t_purchases WHERE purchase_type = '1' AND purchase_category_type = '1' AND supplier_code = ? AND material_name = ? AND shape = ? AND deal_DATE = CAST(? as DATE) %s ) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入する/しない)
    AND seq_no <> CAST(? AS INT)


