-- SQL_GET_REQUEST1
SELECT a.management_no ,COALESCE(b.分納数,1) AS 分納数 ,a.process_sort_no ,a.supplier_code ,COALESCE(c.supplier_abbreviation,'') AS supplier_name ,COALESCE(c.demand_contact_method_type,'2') AS demand_contact_method_type ,d.placing_order_quantity ,d.deadline FROM t_production_plan_details AS a LEFT OUTER JOIN ( SELECT management_no ,MAX(partial_delivery_no) AS 分納数 FROM t_deadline_response_requests GROUP BY management_no ) AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.supplier_code LEFT OUTER JOIN t_placing_orders AS d ON d.management_no = a.management_no AND d.process_sort_no = a.process_sort_no WHERE a.management_no = CAST(? as INT) ORDER BY a.process_sort_no


