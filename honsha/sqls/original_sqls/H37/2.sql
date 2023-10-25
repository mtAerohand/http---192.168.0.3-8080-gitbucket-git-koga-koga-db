﻿-- SQL_GETALL_SELECT_2
SELECT a.品番 ,a.設変番号 ,a.在庫数 ,a.仮受在庫数 ,a.出荷依頼数 ,a.在庫数 - a.出荷依頼数 AS 有効在庫数 ,COALESCE(b.単価,0) AS 単価 ,CAST(trunc(COALESCE(b.単価,0) * a.在庫数 ,0) as BIGINT) AS 金額 ,CASE WHEN a.棚番2 = '' THEN a.棚番1 ELSE a.棚番1 || '-' || a.棚番2 END AS 棚番 ,a.備考 ,COALESCE(c.実績入数,0) AS 実績入数 ,a.補正入数 ,CASE WHEN a.補正入数 <> 0 THEN CEIL(a.在庫数 / a.補正入数) WHEN COALESCE(c.実績入数,0) <> 0 THEN CEIL(a.在庫数 / c.実績入数) ELSE 0 END AS 箱数 ,a.梱包区分 FROM M_在庫 AS a INNER JOIN ( SELECT y.品番, y.設変番号, y.単価 FROM ( SELECT DISTINCT 品番, 設変番号 FROM T_受注 %s ) AS x INNER JOIN ( SELECT 品番, 設変番号, MIN(単価) AS 単価 FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号) AS y ON y.品番 = x.品番 AND y.設変番号 = x.設変番号 ) AS b ON b.品番 = a.品番 AND b.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT x.品番, x.設変番号, MAX(COALESCE(y.個数,0)) AS 実績入数 FROM T_受注 AS x LEFT OUTER JOIN T_売上詳細 AS y ON y.管理No = x.管理No GROUP BY x.品番, x.設変番号 ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 %s ORDER BY a.品番, a.設変番号
    -- 432(上文の%s1に挿入する/しない)
    WHERE 受注番号 = ? AND LENGTH(受注番号) = LENGTH(?)
    -- 432(上文の%s2に挿入する/しない)
    WHERE a.在庫数 <> 0


