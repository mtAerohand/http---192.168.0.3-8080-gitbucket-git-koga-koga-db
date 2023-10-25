-- SQL_GET_ALL
SELECT a.employee_code, a.employee_name ,CASE a.type WHEN '0' THEN '個人' ELSE 'グループ' END AS type ,CASE a.department WHEN '1' THEN '本社' ELSE '工場' END AS department ,CASE a.authority WHEN '1' THEN '一般' WHEN '2' THEN '管理者' ELSE '' END AS authority ,CASE WHEN b.employee_code IS NOT NULL THEN b.employee_name ELSE '' END AS グループ ,a.sort_no ,a.valid_start_DATE ,a.valid_end_DATE FROM m_employees AS a LEFT OUTER JOIN m_employees AS b ON b.employee_code =a.group_employee_code
    -- SQL_GET_ALL_WHERE_CLAUSE_EMPLOYEE
    WHERE a.employee_code = ?
    
    -- SQL_GET_ALL_WHERE_CLAUSE_DEPARTMENT
    WHERE a.department = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.sort_no,a.employee_code


