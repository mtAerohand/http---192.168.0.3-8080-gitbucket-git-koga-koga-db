-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(A.management_no) AS INT)
-- SQL_GET_ALL_EDIT_FROM2
FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code LEFT OUTER JOIN m_customers AS d ON d.customer_code = b.customer_code WHERE ((a.test_type = true AND a.test_result_type = '0') OR (a.test_type = false AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)) )
-- 702
AND a.management_no = CAST(? AS INT)
-- 703
AND a.partial_delivery_no = CAST(? AS INT)


