-- SQL_GETALL_CORE
SELECT a.management_no,a.partial_delivery_no,b.incoming_order_no,b.branch_no,b.part_no,b.engineering_change_no,a.delivery_DATE,a.request_quantity,a.result_registration_DATE,NULL AS 売上registration_DATE,'－' AS SMC現品票output_DATE,b.manager_code,COALESCE(c.employee_name,'') AS manager_name,CASE WHEN b.customer_code = '1' THEN '1' ELSE '0' END AS 得意先区分 FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code WHERE a.ship_type IN ('1','2','3') AND (a.test_type = false OR (a.test_type = true AND a.test_result_type = '1')) AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)

    -- SQL_GETALL_ZYUCHUUBANGOU
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- SQL_GETALL_TANTOUSYA
    AND b.manager_code = ?
    
-- SQL_GETALL_ORDER_BY
ORDER BY b.part_no, b.engineering_change_no, a.delivery_DATE


