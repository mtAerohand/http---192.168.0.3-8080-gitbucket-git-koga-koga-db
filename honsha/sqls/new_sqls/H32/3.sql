-- SQL_GET_REPLY
SELECT a.management_no ,a.partial_delivery_no ,a.response_DATE_type ,a.response_DATE ,a.prospected_delivery_quantity ,a.is_created_fax ,a.fax_remarks ,a.issue_DATE ,c.customer_code ,a.customer_manager_name ,a.manager_code ,COALESCE(b.employee_name,'') AS manager_name FROM t_deadline_responses AS a INNER JOIN t_incoming_orders AS c ON c.management_no = a.management_no LEFT OUTER JOIN m_employees AS b ON b.employee_code = a.manager_code WHERE a.management_no = CAST(? as INT) ORDER BY a.partial_delivery_no


