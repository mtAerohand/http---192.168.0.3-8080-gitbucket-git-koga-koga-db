-- SQL_REPORT_25_COUNT_TEMPLATE
SELECT CAST(COUNT(supplier_code) AS INT) %s %s %s
-- SQL_REPORT_25_COMMON(%s1)
FROM ( SELECT a.supplier_code ,COALESCE(f.supplier_name, '') AS 作業区 ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,a.placing_order_DATE ,a.deadline ,a.placing_order_quantity ,COALESCE(( SELECT SUM(acceptance_quantity) FROM t_process_acceptances WHERE placing_order_no = a.placing_order_no GROUP BY placing_order_no ), 0) AS 総acceptance_quantity ,COALESCE(c.requested_delivery_quantity, 0) AS 回答数 ,c.response_DATE ,g.customer_abbreviation ,EXISTS( SELECT * FROM t_incoming_orders AS ia WHERE ia.part_no = b.part_no AND incoming_order_type IN ('2', '3') AND NOT EXISTS ( SELECT * FROM t_sales AS ib WHERE ib.management_no = ia.management_no AND ib.delivery_form_type IN ('1', '2', '4') ) ) AS 受注有無 ,COALESCE(d.correct_quantity, 0) AS correct_quantity ,COALESCE(e.実績quantity, 0) AS 実績quantity FROM ( SELECT * FROM t_placing_orders AS aa WHERE aa.final_process_type = true AND NOT EXISTS ( SELECT * FROM t_process_acceptances AS ab WHERE aa.placing_order_no = ab.placing_order_no AND ab.acceptance_form_type IN ('1', '2') ) ) AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN t_deadline_response_requests AS c ON c.management_no = a.management_no AND c.process_sort_no = a.process_sort_no AND c.response_DATE IS NOT NULL LEFT OUTER JOIN ( SELECT da.part_no ,da.correct_quantity FROM m_stocks AS da INNER JOIN ( SELECT part_no ,MAX(engineering_change_no) AS engineering_change_no FROM m_stocks GROUP BY part_no ) AS db ON db.part_no = da.part_no AND db.engineering_change_no = da.engineering_change_no ) AS d ON d.part_no = b.part_no LEFT OUTER JOIN ( SELECT ec.part_no ,MAX(eb.quantity) AS 実績quantity FROM t_sales AS ea LEFT OUTER JOIN t_sales_details AS eb ON eb.management_no = ea.management_no INNER JOIN t_incoming_orders AS ec ON ec.management_no = ea.management_no INNER JOIN ( SELECT edc.part_no ,MAX(edc.engineering_change_no) AS engineering_change_no FROM t_sales AS eda LEFT OUTER JOIN t_sales_details AS edb ON edb.management_no = eda.management_no INNER JOIN t_incoming_orders AS edc ON edc.management_no = eda.management_no GROUP BY edc.part_no ) AS ed ON ed.part_no = ec.part_no AND ed.engineering_change_no = ec.engineering_change_no GROUP BY ec.part_no, ec.engineering_change_no ) AS e ON e.part_no = b.part_no LEFT OUTER JOIN m_suppliers AS f ON f.supplier_code = a.supplier_code LEFT OUTER JOIN m_customers AS g ON g.customer_code = b.customer_code) AS h
    -- SQL_REPORT_25_WHERE_SAGYOUKU(%s2)
    WHERE supplier_code = ?
        -- 2367
        AND
        WHERE
    -- SQL_REPORT_25_WHERE_KAITOUBI(%s3)
    response_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END AS DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END AS DATE)
    -- SQL_REPORT_25_ORDERBY(%s4)
    ORDER BY deadline, response_DATE


