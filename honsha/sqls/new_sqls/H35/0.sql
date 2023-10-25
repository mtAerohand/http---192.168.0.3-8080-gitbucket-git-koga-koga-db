-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(x.management_no) AS INT) FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT DISTINCT a.management_no ,a.process_sort_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,a.supplier_code ,COALESCE(c.supplier_abbreviation,'') AS supplier_name ,CASE a.contact_method_type WHEN '1' THEN COALESCE(d.manager_name,'') ELSE a.supplier_manager_name END AS supplier_manager_name ,a.manager_code ,COALESCE(e.employee_name,'') AS 連絡者名 ,a.demand_DATE ,CASE WHEN a.response_deadline < CURRENT_TIMESTAMP THEN 1 ELSE 0 END AS カラー区分 ,a.response_deadline FROM t_deadline_response_requests AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.supplier_code LEFT OUTER JOIN m_supplier_managers AS d ON d.supplier_code = a.supplier_code AND d.manager_code = a.supplier_manager_code LEFT OUTER JOIN m_employees AS e ON e.employee_code = a.manager_code WHERE a.response_DATE IS NULL )as x WHERE x.demand_DATE IS NOT NULL AND x.demand_DATE BETWEEN CAST(CASE WHEN ? =''THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? =''THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM t_process_acceptances WHERE management_no = x.management_no AND process_sort_no = x.process_sort_no AND acceptance_form_type IN ('1','2'))

    -- SQL_GET_WHERE_CLAUSE_WORK_DIVISION_NO
    AND x.supplier_code = ?
    
    -- SQL_GET_WHERE_CLAUSE_PERSON_NO
    AND x.manager_code = ?

    -- SQL_GET_WHERE_CLAUSE_WORK_DIVISION_NO
    AND x.supplier_code = ?
    -- SQL_GET_WHERE_CLAUSE_LIMIT_DATE
    AND x.response_deadline < CURRENT_TIMESTAMP

    -- SQL_GET_WHERE_CLAUSE_PERSON_NO
    AND x.manager_code = ?
    -- SQL_GET_WHERE_CLAUSE_LIMIT_DATE
    AND x.response_deadline < CURRENT_TIMESTAMP
