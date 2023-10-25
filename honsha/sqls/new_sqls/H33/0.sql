-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(z.customer_manager_name) AS INT) FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT a.customer_code ,COALESCE(b.customer_name,'') AS customer_name ,a.customer_manager_name ,a.件数 ,a.manager_code ,COALESCE(employee_name,'') AS manager_name ,b.sort_no FROM ( SELECT y.customer_code ,x.customer_manager_name ,x.manager_code ,CAST(COUNT(x.management_no) AS INT) AS 件数 FROM t_deadline_responses AS x INNER JOIN t_incoming_orders AS y ON y.management_no = x.management_no WHERE x.is_created_fax = true GROUP BY y.customer_code, x.customer_manager_name, X.manager_code ) AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_employees AS c ON c.employee_code = a.manager_code) as z WHERE z.manager_code = ?


