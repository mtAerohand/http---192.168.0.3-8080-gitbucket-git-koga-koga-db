-- SQL_GETALL_UPDATE_CORE
SELECT a.management_no,a.partial_delivery_no,b.incoming_order_no,b.branch_no,b.part_no,b.engineering_change_no,a.delivery_DATE,a.request_quantity,d.result_registration_DATE,a.registration_DATE,CASE WHEN e.print_DATE IS NULL THEN '－' ELSE TO_CHAR(e.print_DATE, 'YYYY/MM/DD') END AS print_DATE,b.manager_code,COALESCE(c.employee_name,'') AS manager_name,CASE WHEN b.customer_code = '1' THEN '1' ELSE '0' END AS 得意先区分 FROM t_sales AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code INNER JOIN t_test_and_ship_requests AS d ON d.management_no = a.management_no AND d.partial_delivery_no = a.partial_delivery_no AND d.ship_type IN ('1','2','3') LEFT OUTER JOIN ( SELECT management_no ,partial_delivery_no ,MAX(print_DATE) AS print_DATE FROM t_item_tags GROUP BY management_no,partial_delivery_no ) AS e ON e.management_no = a.management_no AND e.partial_delivery_no = a.partial_delivery_no WHERE a.registration_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)

    -- SQL_GETALL_ZYUCHUUBANGOU
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- SQL_GETALL_TANTOUSYA
    AND b.manager_code = ?

-- SQL_GETALL_ORDER_BY
ORDER BY b.part_no, b.engineering_change_no, a.delivery_DATE
