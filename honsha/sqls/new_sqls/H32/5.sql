-- SQL_GET_REPLY_MAIL
SELECT a.management_no ,b.customer_code ,COALESCE(d.customer_name,'') AS customer_name ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,b.part_name ,a.response_DATE ,c.partial_delivery_no ,c.response_DATE AS 分納response_DATE ,c.prospected_delivery_quantity FROM ( SELECT management_no ,MIN(response_DATE) AS response_DATE FROM t_deadline_responses WHERE response_DATE IS NOT NULL GROUP BY management_no ) AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no INNER JOIN t_deadline_responses AS c ON c.management_no = a.management_no AND c.response_DATE IS NOT NULL LEFT OUTER JOIN m_customers AS d ON d.customer_code = b.customer_code WHERE a.management_no = CAST(? as INT)


