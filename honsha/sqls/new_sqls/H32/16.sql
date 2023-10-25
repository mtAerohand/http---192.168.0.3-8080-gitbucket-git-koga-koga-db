-- SQL_GET_ORDER_QUANTITY
SELECT FLOOR(COALESCE(a.incoming_order_quantity,0) / 6) AS 月平均 ,COALESCE(b.incoming_order_quantity,0) AS 年合計 FROM ( SELECT SUM(incoming_order_quantity) AS incoming_order_quantity FROM t_incoming_orders WHERE deadline BETWEEN CURRENT_DATE - interval '6 month' AND CURRENT_DATE - interval '1 day' AND incoming_order_type IN ('2','3') AND LEFT(incoming_order_no,8) = ? ) AS a CROSS JOIN ( SELECT SUM(incoming_order_quantity) AS incoming_order_quantity FROM t_incoming_orders WHERE deadline BETWEEN CURRENT_DATE - interval '1 year' AND CURRENT_DATE - interval '1 day' AND incoming_order_type IN ('2','3') AND LEFT(incoming_order_no,8) = ? ) AS b


