-- SQL_GETALL_SELECT_COUNT_2
SELECT CAST(COUNT(a.品番) AS INT) FROM M_在庫 AS a INNER JOIN ( SELECT y.品番, y.設変番号, y.単価 FROM ( SELECT DISTINCT 品番, 設変番号 FROM T_受注 %s ) AS x INNER JOIN ( SELECT 品番, 設変番号, MIN(単価) AS 単価 FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号) AS y ON y.品番 = x.品番 AND y.設変番号 = x.設変番号 ) AS b ON b.品番 = a.品番 AND b.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT x.品番, x.設変番号, MAX(COALESCE(y.個数,0)) AS 実績入数 FROM T_受注 AS x LEFT OUTER JOIN T_売上詳細 AS y ON y.管理No = x.管理No GROUP BY x.品番, x.設変番号 ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 %s
    -- 428(上文の%s1に挿入する/しない)
    WHERE 管理No = CAST(? as INT)
    -- 428(上文の%s2に挿入する/しない)
    WHERE a.在庫数 <> 0


