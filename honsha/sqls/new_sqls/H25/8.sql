-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM t_sales_options WHERE deal_type = ? AND deal_code = ? AND part_no = ? AND engineering_change_no = ? AND sales_DATE = ? %s ) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入される/されない)
    AND seq_no <> ?
