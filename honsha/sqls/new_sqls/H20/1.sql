-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.management_no) AS INT) FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no WHERE a.test_type = true AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)
    -- SQL_WHERE_DIVID
    AND a.management_no = CAST(? AS INT) AND a.partial_delivery_no = CAST(? AS INT)

    -- SQL_WHERE_UNCHECK
    AND a.test_result_type = '0'

    -- SQL_WHERE_UNCHECK
    AND a.test_result_type = '0'
    -- SQL_WHERE_ORDER
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)

    -- SQL_WHERE_CHECK
    AND a.test_result_type <> '0' AND a.result_registration_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_WHERE_ORDER
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)


