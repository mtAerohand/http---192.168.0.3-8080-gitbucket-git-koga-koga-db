-- SQL_GET_ALL
SELECT a.placing_order_no ,a.partial_delivery_no ,a.acceptance_DATE ,a.acceptance_quantity ,a.acceptance_form_type ,CASE a.acceptance_form_type WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,a.unit_price ,a.price FROM t_process_acceptances AS a
-- SQL_GET_PURCHASE_WHERE_CLAUSE_CHECK_NO
WHERE a.placing_order_no = CAST(? AS INT)
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.partial_delivery_no


