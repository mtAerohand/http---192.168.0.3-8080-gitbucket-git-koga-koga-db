-- SQL_GETALL_SELECT_COUNT_2
SELECT CAST(COUNT(a.part_no) AS INT) FROM m_stocks AS a INNER JOIN ( SELECT y.part_no, y.engineering_change_no, y.unit_price FROM ( SELECT DISTINCT part_no, engineering_change_no FROM t_incoming_orders %s ) AS x INNER JOIN ( SELECT part_no, engineering_change_no, MIN(unit_price) AS unit_price FROM t_incoming_orders WHERE unit_price <> 0 GROUP BY part_no, engineering_change_no) AS y ON y.part_no = x.part_no AND y.engineering_change_no = x.engineering_change_no ) AS b ON b.part_no = a.part_no AND b.engineering_change_no = a.engineering_change_no LEFT OUTER JOIN ( SELECT x.part_no, x.engineering_change_no, MAX(COALESCE(y.quantity,0)) AS 実績quantity FROM t_incoming_orders AS x LEFT OUTER JOIN t_sales_details AS y ON y.management_no = x.management_no GROUP BY x.part_no, x.engineering_change_no ) AS c ON c.part_no = a.part_no AND c.engineering_change_no = a.engineering_change_no %s
    -- 432(上文の%s1に挿入する/しない)
    WHERE incoming_order_no = ? AND LENGTH(incoming_order_no) = LENGTH(?)
    -- 432(上文の%s2に挿入する/しない)
    WHERE a.stock_quantity <> 0


