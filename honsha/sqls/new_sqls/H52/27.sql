-- SQL_REPORT_13_COUNT
SELECT CAST(COUNT(a.customer_code) AS INT)
-- SQL_REPORT_13_CORE1
FROM ( SELECT x.customer_code ,CAST(COUNT(x.customer_code) AS INT) AS 受注残件数 ,CAST(SUM(x.受注残price) AS BIGINT) AS 受注残price FROM ( SELECT a.customer_code ,CASE WHEN a.incoming_order_quantity - COALESCE(c.完了数,0) > 0 THEN CASE b.price_round_type WHEN '1' THEN CAST(FLOOR(a.unit_price * (a.incoming_order_quantity - COALESCE(c.完了数,0))) as BIGINT) WHEN '2' THEN CAST(CEIL(a.unit_price * (a.incoming_order_quantity - COALESCE(c.完了数,0))) as BIGINT) ELSE CAST(ROUND((a.unit_price * (a.incoming_order_quantity - COALESCE(c.完了数,0))),0) as BIGINT) END ELSE 0 END AS 受注残price FROM t_incoming_orders AS a INNER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN ( SELECT management_no ,SUM(request_quantity) AS 完了数 FROM t_sales GROUP BY management_no ) AS c ON c.management_no = a.management_no WHERE a.incoming_order_type IN ('2','3') AND NOT EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no AND delivery_form_type IN ('1','2','4'))
    -- SQL_REPORT_NOUKI
    AND a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
-- SQL_REPORT_13_CORE2
) AS x GROUP BY x.customer_code ) AS A INNER JOIN m_customers AS B ON B.customer_code = A.customer_code
    -- SQL_REPORT_13_ORDER_BY
    ORDER BY A.受注残price DESC, B.sort_no, A.customer_code


