-- SQL_GET_ALL_EDIT_SELECT
SELECT a.management_no ,a.partial_delivery_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,b.deadline ,b.incoming_order_quantity ,a.request_DATE ,a.request_quantity ,b.manager_code ,COALESCE(c.employee_name,'') AS manager_name ,CASE b.incoming_order_type WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS incoming_order_type ,b.customer_code ,COALESCE(d.customer_abbreviation,'') AS customer_name
-- SQL_GET_ALL_EDIT_FROM
FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code LEFT OUTER JOIN m_customers AS d ON d.customer_code = b.customer_code WHERE a.request_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) AND ((a.test_type = true AND a.test_result_type = '0') OR (a.test_type = false AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)) )
    -- 836
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- 838
    AND b.manager_code = ?
    -- SQL_GET_ALL_EDIT_ORDER
    ORDER BY a.request_DATE DESC, b.part_no, b.engineering_change_no, b.deadline

    -- 836
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- SQL_GET_ALL_EDIT_ORDER
    ORDER BY a.request_DATE DESC, b.part_no, b.engineering_change_no, b.deadline

    -- 838
    AND b.manager_code = ?
    -- SQL_GET_ALL_EDIT_ORDER
    ORDER BY a.request_DATE DESC, b.part_no, b.engineering_change_no, b.deadline

    -- SQL_GET_ALL_EDIT_ORDER
    ORDER BY a.request_DATE DESC, b.part_no, b.engineering_change_no, b.deadline


