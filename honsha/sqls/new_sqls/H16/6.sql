-- SQL_BEFORE_PROCESS_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM t_process_acceptances WHERE management_no = CAST(? AS INT) AND process_sort_no = (CAST(? AS INT) - 1)) THEN 1 ELSE 0 END AS 判定


