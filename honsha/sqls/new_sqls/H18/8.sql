-- SQL_GET_ALL_NEW_KENSA_SELECT
SELECT A.management_no ,COALESCE(C.partial_delivery_no,0) + 1 AS partial_delivery_no ,A.incoming_order_no ,A.branch_no ,A.part_no ,A.engineering_change_no ,A.deadline ,A.incoming_order_quantity ,C.request_DATE ,C.request_quantity ,A.manager_code ,COALESCE(D.employee_name,'') AS manager_name ,CASE A.incoming_order_type WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS incoming_order_type ,A.customer_code ,COALESCE(E.customer_abbreviation,'') AS customer_name
-- SQL_GET_ALL_NEW_KENSA_FROM
FROM ( SELECT DISTINCT a.management_no ,a.incoming_order_no ,a.branch_no ,a.part_no ,a.engineering_change_no ,a.deadline ,a.incoming_order_quantity ,a.manager_code ,a.incoming_order_type ,a.customer_code FROM t_incoming_orders AS a INNER JOIN t_placing_orders AS b ON b.management_no = a.management_no AND b.final_process_type = true INNER JOIN t_process_acceptances AS c ON c.management_no = b.management_no AND c.process_sort_no = b.process_sort_no ) AS A LEFT OUTER JOIN ( SELECT management_no ,MAX(partial_delivery_no) AS partial_delivery_no FROM t_test_and_ship_requests GROUP BY management_no ) AS B ON B.management_no = A.management_no LEFT OUTER JOIN t_test_and_ship_requests AS C ON C.management_no = B.management_no AND C.partial_delivery_no = B.partial_delivery_no LEFT OUTER JOIN m_employees AS D ON D.employee_code = A.manager_code LEFT OUTER JOIN m_customers AS E ON E.customer_code = A.customer_code WHERE NOT EXISTS ( SELECT * FROM t_test_and_ship_requests WHERE management_no = A.management_no AND (delivery_form_type IN ('1','2','4','11','12') OR (test_type =true AND test_result_type = '0'))) AND EXISTS ( SELECT * FROM m_stocks WHERE part_no = A.part_no AND engineering_change_no = A.engineering_change_no AND suspense_stock_quantity > 0 )
    -- 723
    AND A.incoming_order_no &@ ? AND LENGTH(A.incoming_order_no) = LENGTH(?)
    -- 725
    AND A.manager_code = ?
    -- SQL_GET_ALL_NEW_KENSA_ORDER
    ORDER BY A.part_no, A.engineering_change_no, A.deadline, A.incoming_order_no

    -- 723
    AND A.incoming_order_no &@ ? AND LENGTH(A.incoming_order_no) = LENGTH(?)
    -- SQL_GET_ALL_NEW_KENSA_ORDER
    ORDER BY A.part_no, A.engineering_change_no, A.deadline, A.incoming_order_no

    -- 725
    AND A.manager_code = ?
    -- SQL_GET_ALL_NEW_KENSA_ORDER
    ORDER BY A.part_no, A.engineering_change_no, A.deadline, A.incoming_order_no

    -- SQL_GET_ALL_NEW_KENSA_ORDER
    ORDER BY A.part_no, A.engineering_change_no, A.deadline, A.incoming_order_no
