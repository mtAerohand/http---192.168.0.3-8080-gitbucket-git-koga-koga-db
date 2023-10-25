-- SQL_GETALL_SELECT_COUNT_1
SELECT CAST(COUNT(a.part_no) AS INT) FROM m_stocks AS a LEFT OUTER JOIN ( SELECT part_no, engineering_change_no, MIN(unit_price) AS unit_price FROM t_incoming_orders WHERE unit_price <> 0 GROUP BY part_no, engineering_change_no ) AS b ON b.part_no = a.part_no AND b.engineering_change_no = a.engineering_change_no LEFT OUTER JOIN ( SELECT x.part_no, x.engineering_change_no, MAX(COALESCE(y.quantity,0)) AS 実績quantity FROM t_incoming_orders AS x LEFT OUTER JOIN t_sales_details AS y ON y.management_no = x.management_no GROUP BY x.part_no, x.engineering_change_no ) AS c ON c.part_no = a.part_no AND c.engineering_change_no = a.engineering_change_no %s %s %s
    -- 443(%s1)
    WHERE a.part_no &^ ?
    -- 448(%s2)
    AND a.engineering_change_no = ?
    -- 452(%s3)
    AND a.stock_quantity <> 0


