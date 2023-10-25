-- SQL_REPORT_61_COUNT_TEMPLATE
SELECT CAST(COUNT(c.customer_code) AS INT) %s %s %s
-- SQL_REPORT_61_COMMON(%s1)
FROM m_stocks AS a LEFT OUTER JOIN ( SELECT x.part_no, x.engineering_change_no, x.unit_price, CASE WHEN LEFT(x.customer_code,2) = '00' THEN RIGHT(x.customer_code,1) WHEN LEFT(x.customer_code,1) = '0' THEN RIGHT(x.customer_code,2) ELSE x.customer_code END AS customer_code FROM ( SELECT part_no, engineering_change_no, MIN(unit_price) AS unit_price, MIN(RIGHT('000' || customer_code, 3)) AS customer_code FROM t_incoming_orders WHERE unit_price <> 0 GROUP BY part_no, engineering_change_no ) AS x ) AS c ON c.part_no = a.part_no AND c.engineering_change_no = a.engineering_change_no LEFT OUTER JOIN m_customers AS d ON d.customer_code = c.customer_code LEFT OUTER JOIN ( SELECT y.part_no, y.engineering_change_no, MAX(x.delivery_DATE) AS delivery_DATE, MAX(COALESCE(z.quantity,0)) AS 実績quantity FROM t_sales AS x LEFT OUTER JOIN t_sales_details AS z ON z.management_no = x.management_no INNER JOIN t_incoming_orders AS y ON y.management_no = x.management_no GROUP BY y.part_no, y.engineering_change_no ) AS e ON e.part_no = a.part_no AND e.engineering_change_no = a.engineering_change_no WHERE COALESCE(e.delivery_DATE,'9999-12-31') <= CURRENT_DATE - CAST(? || ' month' AS INTERVAL)
    -- SQL_REPORT_61_WHERE_TOKUISAKI(%s2)
    AND COALESCE(c.customer_code,'') = ?
    -- SQL_REPORT_61_ORDERBY(%s3)
    ORDER BY COALESCE(d.sort_no,0), COALESCE(c.customer_code,''), a.part_no, a.engineering_change_no


