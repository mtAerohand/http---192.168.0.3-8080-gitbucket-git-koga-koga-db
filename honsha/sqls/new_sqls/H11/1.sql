-- SQL_GET_ALL
SELECT * FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT a.management_no ,a.incoming_order_no ,a.branch_no ,a.part_no ,a.engineering_change_no ,a.incoming_order_DATE ,a.deadline ,b.registration_DATE AS 計画作成日 ,CASE WHEN EXISTS (SELECT * FROM t_placing_orders WHERE management_no = a.management_no) THEN '済' ELSE '' END AS 発注状況 ,a.manager_code ,COALESCE(c.employee_name,'') AS manager_name ,CASE a.incoming_order_type WHEN '1' THEN '先行手配' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS incoming_order_type ,a.customer_code ,COALESCE(d.customer_abbreviation,'') AS customer_name FROM t_incoming_orders AS a LEFT OUTER JOIN t_production_plans AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_employees AS c ON c.employee_code = a.manager_code LEFT OUTER JOIN m_customers AS d ON d.customer_code = a.customer_code WHERE a.incoming_order_type <> '2' ) AS x
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    x.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND x.incoming_order_no &@ ? AND LENGTH(x.incoming_order_no) = LENGTH(?)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.incoming_order_DATE DESC, part_no
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.incoming_order_DATE DESC, part_no

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    x.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    AND x.part_no &@ ? AND LENGTH(x.part_no) = LENGTH(?)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.incoming_order_DATE DESC, part_no
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.incoming_order_DATE DESC, part_no

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    x.incoming_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.incoming_order_DATE DESC, part_no
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.incoming_order_DATE DESC, part_no

    -- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
    x.management_no = CAST(? as INT)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.incoming_order_DATE DESC, part_no
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.incoming_order_DATE DESC, part_no



