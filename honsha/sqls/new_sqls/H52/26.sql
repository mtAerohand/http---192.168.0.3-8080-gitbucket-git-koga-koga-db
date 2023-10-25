-- SQL_REPORT_12_SELECT
SELECT CASE WHEN a.deadline < CURRENT_DATE THEN '*' ELSE '' END AS 遅れ,a.customer_code, COALESCE(b.customer_name,'') AS customer_name, a.incoming_order_no, a.branch_no, a.part_no, a.engineering_change_no,a.part_name, a.customer_part_no, a.incoming_order_DATE, a.deadline, c.response_DATE, d.delivery_DATE AS 出荷予定日, a.incoming_order_quantity, a.unit_price, CASE COALESCE(b.price_round_type,'1') WHEN '1' THEN CAST(FLOOR(a.unit_price * a.incoming_order_quantity) as BIGINT) WHEN '2' THEN CAST(CEIL(a.unit_price * a.incoming_order_quantity) as BIGINT) ELSE CAST(ROUND((a.unit_price * a.incoming_order_quantity),0) as BIGINT) END AS 受注price,a.incoming_order_quantity - COALESCE(e.完了数,0) AS 受注残数,CASE WHEN a.incoming_order_quantity - COALESCE(e.完了数,0) > 0 THEN CASE COALESCE(b.price_round_type,'1') WHEN '1' THEN CAST(FLOOR(a.unit_price * (a.incoming_order_quantity - COALESCE(e.完了数,0))) as BIGINT) WHEN '2' THEN CAST(CEIL(a.unit_price * (a.incoming_order_quantity - COALESCE(e.完了数,0))) as BIGINT) ELSE CAST(ROUND((a.unit_price * (a.incoming_order_quantity - COALESCE(e.完了数,0))),0) as BIGINT) END ELSE 0 END AS 受注残price,a.biller,a.management_no,a.delivery_place_name,a.next_process_name,CASE WHEN COALESCE(f.correct_quantity,0) <> 0 THEN f.correct_quantity ELSE COALESCE(g.実績quantity,0) END AS quantity,CASE WHEN COALESCE(f.correct_quantity,0) <> 0 THEN CEIL((a.incoming_order_quantity - COALESCE(e.完了数,0)) / f.correct_quantity) WHEN COALESCE(g.実績quantity,0) <> 0 THEN CEIL((a.incoming_order_quantity - COALESCE(e.完了数,0)) / g.実績quantity) ELSE 0 END AS 箱数
-- SQL_REPORT_12_CORE
FROM t_incoming_orders AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN ( SELECT management_no, MAX(response_DATE) AS response_DATE FROM t_deadline_responses GROUP BY management_no) AS c ON c.management_no = a.management_no LEFT OUTER JOIN ( SELECT x.management_no, x.delivery_DATE FROM t_test_and_ship_requests AS x WHERE x.test_result_type <> '2' AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = x.management_no AND partial_delivery_no = x.partial_delivery_no)) AS d ON d.management_no = a.management_no LEFT OUTER JOIN ( SELECT management_no,SUM(request_quantity) AS 完了数 FROM t_sales GROUP BY management_no) AS e ON e.management_no = a.management_no LEFT OUTER JOIN m_stocks AS f ON f.part_no = a.part_no AND f.engineering_change_no = a.engineering_change_no LEFT OUTER JOIN ( SELECT y.part_no, y.engineering_change_no, MAX(COALESCE(x.quantity,0)) AS 実績quantity FROM t_sales_details AS x INNER JOIN t_incoming_orders AS y ON y.management_no = x.management_no GROUP BY y.part_no, y.engineering_change_no ) AS g ON g.part_no = a.part_no AND g.engineering_change_no = a.engineering_change_no WHERE a.incoming_order_type IN ('2','3') AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND delivery_form_type IN ('1','2','4'))
    -- SQL_REPORT_NOUKI
    AND a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_TOKUISAKI
    AND a.customer_code = ?
    -- SQL_REPORT_HINBAN
    AND a.part_no &^ ?
    -- SQL_REPORT_12_CHUUBAN_ALPHABET
    AND LEFT(a.incoming_order_no,1) !~ '^[0-9]+$'
    -- SQL_REPORT_12_CHUUBAN_SUUJI
    AND LEFT(a.incoming_order_no,1) ~ '^[0-9]+$'
    -- SQL_REPORT_12_ORDER_BY
    ORDER BY COALESCE(b.sort_no,0), a.customer_code, a.deadline, a.part_no, a.engineering_change_no


