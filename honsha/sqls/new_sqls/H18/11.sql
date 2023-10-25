-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(A.management_no) AS INT)
-- SQL_GET_ALL_EDIT_FROM
FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code LEFT OUTER JOIN m_customers AS d ON d.customer_code = b.customer_code WHERE a.request_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) AND ((a.test_type = true AND a.test_result_type = '0') OR (a.test_type = false AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)) )
    -- 836
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- 838
    AND b.manager_code = ?

    -- 836
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)

    -- 838
    AND b.manager_code = ?
