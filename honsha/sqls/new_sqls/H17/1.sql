-- SQL_LAST_AccEPTANCE_DAY_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM t_process_acceptances WHERE placing_order_no = ? AND partial_delivery_no <> ? AND acceptance_DATE >= CAST(? AS DATE)) THEN 1 ELSE 0 END AS 判定


