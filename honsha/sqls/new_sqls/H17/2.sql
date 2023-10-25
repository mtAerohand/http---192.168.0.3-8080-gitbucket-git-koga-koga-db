-- SQL_FULL_PAYMENT_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM t_process_acceptances WHERE placing_order_no = CAST(? as INT) AND acceptance_form_type IN ('1','2')) THEN 1 ELSE 0 END AS 判定


