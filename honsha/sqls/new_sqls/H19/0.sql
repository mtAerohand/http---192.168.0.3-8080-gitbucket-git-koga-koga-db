-- SQL_BASE
SELECT a.management_no ,a.partial_delivery_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,CASE b.incoming_order_type WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS incoming_order_type ,a.delivery_DATE ,a.request_DATE ,a.output_DATE ,c.employee_code ,COALESCE(c.employee_name,'') AS manager_name ,a.version_no FROM t_test_and_ship_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.user_id = a.upDATEd_by
    -- SQL_OUTPUT
    WHERE a.output_DATE IS NULL AND a.request_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_REPUT
    WHERE a.output_DATE IS NOT NULL AND a.request_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
        -- SQL_TARGET
        AND ((a.test_type = true AND a.test_result_type = '0') OR (a.test_type = false AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND partial_delivery_no = a.partial_delivery_no)))

    -- SQL_ORDER
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- SQL_NAME
    AND c.employee_code = ?
-- SQL_BY
ORDER BY a.request_DATE DESC, b.part_no


