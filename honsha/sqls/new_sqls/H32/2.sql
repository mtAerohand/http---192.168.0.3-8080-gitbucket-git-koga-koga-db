-- SQL_GET_SUPPLIER
SELECT a.management_no ,COALESCE(b.partial_delivery_no,1) AS partial_delivery_no ,a.process_sort_no ,a.supplier_code ,COALESCE(c.supplier_abbreviation,'') AS supplier_name ,a.process_code ,COALESCE(d.process_abbreviation,'') AS process_name ,a.deadline ,b.demand_DATE ,b.requested_delivery_DATE ,b.requested_delivery_quantity ,b.response_DATE ,b.acceptance_DATE ,b.acceptance_quantity ,b.受入形態 FROM t_production_plan_details AS a LEFT OUTER JOIN ( SELECT CASE WHEN x.management_no IS NOT NULL THEN x.management_no ELSE y.management_no END AS management_no ,CASE WHEN x.process_sort_no IS NOT NULL THEN x.process_sort_no ELSE y.process_sort_no END AS process_sort_no ,CASE WHEN x.partial_delivery_no IS NOT NULL THEN x.partial_delivery_no ELSE y.partial_delivery_no END AS partial_delivery_no ,x.demand_DATE ,x.requested_delivery_DATE ,x.requested_delivery_quantity ,x.response_DATE ,y.acceptance_DATE ,y.acceptance_quantity ,CASE COALESCE(y.acceptance_form_type,'') WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 FROM t_deadline_response_requests AS x FULL OUTER JOIN t_process_acceptances AS y ON y.management_no = x.management_no AND y.process_sort_no = x.process_sort_no AND y.partial_delivery_no = x.partial_delivery_no ) AS b ON b.management_no = a.management_no AND b.process_sort_no = a.process_sort_no LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS d ON d.process_code = a.process_code WHERE a.management_no = CAST(? as INT) ORDER BY a.management_no, a.process_sort_no, partial_delivery_no

