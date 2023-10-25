-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.management_no) AS INT)
-- SQL_GET_ALL_FROM_CLAUSE
FROM t_incoming_orders AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_employees AS c ON c.employee_code = a.manager_code
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?)

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    AND a.part_no &@ ? AND LENGTH(a.part_no) = LENGTH(?)

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?)

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)

    -- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
    a.management_no = CAST(? as INT)
