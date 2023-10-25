-- SQL_GETALL_TORIKESHI_SELECT
SELECT a.management_no,b.incoming_order_no,b.branch_no,b.part_no,b.engineering_change_no,b.incoming_order_DATE,b.deadline,0 AS process_sort_no,'' AS supplier_code,'' AS supplier_name,e.placing_order_DATE,b.manager_code,COALESCE(c.employee_name,'') AS manager_name,b.customer_code,COALESCE(d.customer_abbreviation,'') AS customer_name FROM t_production_plans AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no AND b.incoming_order_type <> '2' LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code LEFT OUTER JOIN m_customers AS d ON d.customer_code = b.customer_code INNER JOIN (SELECT DISTINCT management_no, placing_order_DATE FROM t_placing_orders WHERE placing_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)) AS e ON e.management_no = a.management_no WHERE NOT EXISTS (SELECT * FROM t_process_acceptances WHERE management_no = a.management_no)
    -- SQL_GETALL_TORIKESHI_TANTOUSYA
    AND b.manager_code = ?
    -- SQL_GETALL_TORIKESHI_ZYUCHUUBANGOU
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- SQL_GETALL_TORIKESHI_HINBAN
    AND b.part_no &@ ? AND LENGTH(b.part_no) = LENGTH(?)
    
-- SQL_GETALL_TORIKESHI_ORDER_BY
ORDER BY b.incoming_order_no, b.branch_no


