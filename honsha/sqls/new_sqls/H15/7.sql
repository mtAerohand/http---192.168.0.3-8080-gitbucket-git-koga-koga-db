-- SQL_GETALL_SYUTSURYOKU_BUNNOU_SELECT
SELECT a.management_no,b.incoming_order_no,b.branch_no,b.part_no,b.engineering_change_no,b.incoming_order_DATE,b.deadline,f.process_sort_no,f.supplier_code,COALESCE(g.supplier_abbreviation,'') AS supplier_name,e.placing_order_DATE,b.manager_code,COALESCE(c.employee_name,'') AS manager_name,b.customer_code,COALESCE(d.customer_abbreviation,'') AS customer_name FROM t_production_plans AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no AND b.incoming_order_type <> '2' LEFT OUTER JOIN m_employees AS c ON c.employee_code = b.manager_code LEFT OUTER JOIN m_customers AS d ON d.customer_code = b.customer_code INNER JOIN t_production_plan_details AS f ON f.management_no = a.management_no INNER JOIN t_placing_orders AS e ON e.management_no = f.management_no AND e.process_sort_no = f.process_sort_no LEFT OUTER JOIN m_suppliers AS g ON g.supplier_code = f.supplier_code WHERE NOT EXISTS (SELECT * FROM t_process_acceptances WHERE management_no = f.management_no AND process_sort_no = f.process_sort_no AND acceptance_form_type IN ('1','2')) AND EXISTS (SELECT * FROM t_process_acceptances WHERE management_no = f.management_no AND process_sort_no = f.process_sort_no AND acceptance_form_type = '3' AND acceptance_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) AND acceptance_DATE > COALESCE(e.partila_order_DATE,'2000-01-01')) AND COALESCE(g.partial_order_issue_type,false) = true
    -- SQL_GETALL_SYUTSURYOKU_BUNNOU_TANTOUSYA
    AND b.manager_code = ?
    -- SQL_GETALL_SYUTSURYOKU_BUNNOU_ZYUCHUUBANGOU
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
    -- SQL_GETALL_SYUTSURYOKU_BUNNOU_HINBAN
    AND b.part_no &@ ? AND LENGTH(b.part_no) = LENGTH(?)
-- SQL_GETALL_SYUTSURYOKU_BUNNOU_ORDER_BY
ORDER BY b.incoming_order_no, b.branch_no, f.process_sort_no


