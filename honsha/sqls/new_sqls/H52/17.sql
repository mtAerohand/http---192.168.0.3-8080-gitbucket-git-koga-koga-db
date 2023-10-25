-- SQL_REPORT_62_GOUKEI
SELECT SUM(x.stock_quantity) AS stock_quantity計 ,SUM(x.在庫price) AS 在庫price計 FROM ( SELECT a.stock_quantity ,CAST(TRUNC(CAST((COALESCE(c.unit_price,0) * COALESCE(d.在庫製品assessment_rate,0) / 100) as NUMERIC(12,2)) * a.stock_quantity,0) as BIGINT) AS 在庫price FROM m_stocks AS a LEFT OUTER JOIN ( SELECT part_no, engineering_change_no, MIN(unit_price) AS unit_price FROM t_incoming_orders WHERE unit_price <> 0 GROUP BY part_no, engineering_change_no ) AS c ON c.part_no = a.part_no AND c.engineering_change_no = a.engineering_change_no LEFT OUTER JOIN ( SELECT q.part_no ,q.engineering_change_no ,CASE WHEN CURRENT_DATE - interval'1 year' < COALESCE(o.delivery_DATE,q.incoming_order_DATE) THEN p.stock_assessment_rate_1 WHEN CURRENT_DATE - interval'2 year' < COALESCE(o.delivery_DATE,q.incoming_order_DATE) THEN p.stock_assessment_rate_2 WHEN CURRENT_DATE - interval'3 year' < COALESCE(o.delivery_DATE,q.incoming_order_DATE) THEN p.stock_assessment_rate_3 WHEN CURRENT_DATE - interval'5 year' < COALESCE(o.delivery_DATE,q.incoming_order_DATE) THEN p.stock_assessment_rate_4 ELSE p.stock_assessment_rate_5 END AS 在庫製品assessment_rate FROM ( SELECT part_no, engineering_change_no, MAX(incoming_order_DATE) AS incoming_order_DATE FROM t_incoming_orders GROUP BY part_no, engineering_change_no ) AS q LEFT OUTER JOIN ( SELECT y.part_no, y.engineering_change_no, MAX(x.delivery_DATE) AS delivery_DATE FROM t_sales AS x INNER JOIN t_incoming_orders AS y ON y.management_no = x.management_no GROUP BY y.part_no, y.engineering_change_no ) AS o ON o.part_no = q.part_no AND o.engineering_change_no = q.engineering_change_no INNER JOIN m_systems AS p ON p.seq_no = 1 ) AS d ON d.part_no = a.part_no AND d.engineering_change_no = a.engineering_change_no WHERE a.stock_quantity <> 0 ) AS x %s
    -- SQL_REPORT_62_ORDER_BY(%s1)
    ORDER BY a.part_no, a.engineering_change_no


