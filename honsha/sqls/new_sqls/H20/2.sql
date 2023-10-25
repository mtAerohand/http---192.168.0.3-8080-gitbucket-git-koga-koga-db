-- SQL_GET_ALL
SELECT a.management_no,a.partial_delivery_no,a.test_result_type,CASE a.test_result_type WHEN '0' THEN '' WHEN '1' THEN '合 格' WHEN '2' THEN '不合格' ELSE '' END 合否 ,b.incoming_order_no,b.branch_no ,b.part_no,b.engineering_change_no,CASE b.incoming_order_type WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS incoming_order_type,a.delivery_DATE ,a.response_DATE,a.request_DATE,a.result_registration_DATE,a.request_quantity,a.version_no FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no WHERE a.test_type = true AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)
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


