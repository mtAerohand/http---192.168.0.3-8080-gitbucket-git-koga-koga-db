-- SQL_GET_MAIL
SELECT A.management_no ,A.supplier_code ,COALESCE(B.supplier_name,'') AS supplier_name ,A.supplier_manager_code ,A.supplier_manager_name ,C.mail AS 作業区担当者mail ,A.manager_code ,COALESCE(D.employee_name,'') AS manager_name ,COALESCE(D.mail,'') AS 担当者mail ,E.incoming_order_no ,E.part_no ,E.engineering_change_no ,E.branch_no FROM ( SELECT DISTINCT management_no ,supplier_code ,supplier_manager_code ,supplier_manager_name ,manager_code FROM t_deadline_response_requests WHERE has_response_request = true AND request_report_type = '1' AND contact_method_type = '1' ) AS A LEFT OUTER JOIN m_suppliers AS B ON B.supplier_code = A.supplier_code LEFT OUTER JOIN m_supplier_managers AS C ON C.supplier_code = A.supplier_code AND C.manager_code = A.supplier_manager_code LEFT OUTER JOIN m_employees AS D ON D.employee_code = A.manager_code INNER JOIN t_incoming_orders AS E ON E.management_no = A.management_no WHERE A.management_no
-- H34/578
IN (?)
-- SQL_GET_MAIL_ORDER
ORDER BY E.part_no, E.engineering_change_no


