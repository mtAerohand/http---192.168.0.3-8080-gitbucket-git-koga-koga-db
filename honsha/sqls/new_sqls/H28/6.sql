-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM t_acceptance_returns WHERE return_DATE = CAST(? as DATE) AND management_no = CAST(? AS INT) AND process_sort_no = CAST(? AS INT) %s ) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入する/しない)
    AND seq_no <> CAST(? AS INT)
