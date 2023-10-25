-- SQL_GETALL_SELECT_1
SELECT a.part_no ,a.engineering_change_no ,a.stock_quantity ,a.suspense_stock_quantity ,a.ship_request_quantity ,a.stock_quantity - a.ship_request_quantity AS 有効stock_quantity ,COALESCE(b.unit_price,0) AS unit_price ,CAST(trunc(COALESCE(b.unit_price,0) * a.stock_quantity ,0) as BIGINT) AS price ,CASE WHEN a.bin_2 = '' THEN a.bin_1 ELSE a.bin_1 || '-' || a.bin_2 END AS bin ,a.remarks ,COALESCE(c.実績quantity,0) AS 実績quantity ,a.correct_quantity ,CASE WHEN a.correct_quantity <> 0 THEN CEIL(a.stock_quantity / a.correct_quantity) WHEN COALESCE(c.実績quantity,0) <> 0 THEN CEIL(a.stock_quantity / c.実績quantity) ELSE 0 END AS 箱数 ,a.packing_type FROM m_stocks AS a LEFT OUTER JOIN ( SELECT part_no, engineering_change_no, MIN(unit_price) AS unit_price FROM t_incoming_orders WHERE unit_price <> 0 GROUP BY part_no, engineering_change_no ) AS b ON b.part_no = a.part_no AND b.engineering_change_no = a.engineering_change_no LEFT OUTER JOIN ( SELECT x.part_no, x.engineering_change_no, MAX(COALESCE(y.quantity,0)) AS 実績quantity FROM t_incoming_orders AS x LEFT OUTER JOIN t_sales_details AS y ON y.management_no = x.management_no GROUP BY x.part_no, x.engineering_change_no ) AS c ON c.part_no = a.part_no AND c.engineering_change_no = a.engineering_change_no %s %s %s ORDER BY a.part_no, a.engineering_change_no
    -- 443(%s1)
    WHERE a.part_no &^ ?
    -- 448(%s2)
    AND a.engineering_change_no = ?
    -- 452(%s3)
    AND a.stock_quantity <> 0


