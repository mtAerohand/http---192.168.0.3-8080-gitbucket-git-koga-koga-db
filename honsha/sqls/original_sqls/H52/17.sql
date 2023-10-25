-- SQL_REPORT_62_GOUKEI
SELECT SUM(x.在庫数) AS 在庫数計 ,SUM(x.在庫金額) AS 在庫金額計 FROM ( SELECT a.在庫数 ,CAST(TRUNC(CAST((COALESCE(c.単価,0) * COALESCE(d.在庫製品評価率,0) / 100) as NUMERIC(12,2)) * a.在庫数,0) as BIGINT) AS 在庫金額 FROM M_在庫 AS a LEFT OUTER JOIN ( SELECT 品番, 設変番号, MIN(単価) AS 単価 FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号 ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT q.品番 ,q.設変番号 ,CASE WHEN CURRENT_DATE - interval'1 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率1 WHEN CURRENT_DATE - interval'2 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率2 WHEN CURRENT_DATE - interval'3 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率3 WHEN CURRENT_DATE - interval'5 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率4 ELSE p.在庫製品評価率5 END AS 在庫製品評価率 FROM ( SELECT 品番, 設変番号, MAX(受注日) AS 受注日 FROM T_受注 GROUP BY 品番, 設変番号 ) AS q LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(x.納入日) AS 納入日 FROM T_売上 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS o ON o.品番 = q.品番 AND o.設変番号 = q.設変番号 INNER JOIN M_システム AS p ON p.SeqNo = 1 ) AS d ON d.品番 = a.品番 AND d.設変番号 = a.設変番号 WHERE a.在庫数 <> 0 ) AS x %s
    -- SQL_REPORT_62_ORDER_BY(%s1)
    ORDER BY a.品番, a.設変番号


