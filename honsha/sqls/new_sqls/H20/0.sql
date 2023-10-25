-- SQL_GET_DATA
SELECT a.management_no,a.partial_delivery_no,b.incoming_order_no,b.branch_no,b.part_no,b.engineering_change_no,a.version_no,request_quantity FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no WHERE a.management_no = CAST(? AS INT) AND a.test_type = true AND a.test_result_type = '0'


