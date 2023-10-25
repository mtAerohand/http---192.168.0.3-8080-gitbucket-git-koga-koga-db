-- SQL_GET_LAST_TIME_DELIVERY
SELECT MAX(delivery_DATE) AS delivery_DATE FROM t_test_and_ship_requests WHERE management_no = CAST(? as INT) AND partial_delivery_no <> CAST(? as INT)
