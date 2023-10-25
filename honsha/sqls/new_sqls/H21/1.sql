-- SQL_SMC_JUDGE
SELECT CASE WHEN customer_code = '1' THEN 1 ELSE 0 END AS 判定 FROM t_incoming_orders WHERE management_no = CAST(? as INT)


