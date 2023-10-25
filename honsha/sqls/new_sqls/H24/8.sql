-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM t_sales_returns WHERE customer_code = ? AND part_no = ? AND engineering_change_no = ? AND return_DATE = CAST(? as DATE) %s) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(SQL_EXISTS_SELECTの%sに入る/入らない)
    AND seq_no <> CAST(? AS INT)
