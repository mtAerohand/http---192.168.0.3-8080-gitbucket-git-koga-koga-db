-- SQL_GET_ALL
SELECT a.management_no ,a.customer_code ,COALESCE(b.customer_abbreviation,'') AS customer_name ,a.incoming_order_no ,a.branch_no ,a.part_no ,a.engineering_change_no ,CASE a.incoming_order_type WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS incoming_order_type ,a.manager_code ,COALESCE(c.employee_name,'') AS manager_name ,a.incoming_order_DATE ,a.deadline ,a.incoming_order_quantity ,a.unit_price
-- SQL_GET_ALL_FROM_CLAUSE
FROM t_incoming_orders AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_employees AS c ON c.employee_code = a.manager_code
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.incoming_order_DATE DESC, a.part_no, a.incoming_order_no

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    AND a.part_no &@ ? AND LENGTH(a.part_no) = LENGTH(?)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.incoming_order_DATE DESC, a.part_no, a.incoming_order_no

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.incoming_order_DATE DESC, a.part_no, a.incoming_order_no

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.incoming_order_DATE DESC, a.part_no, a.incoming_order_no

    -- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
    a.management_no = CAST(? as INT)


