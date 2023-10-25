-- SQL_REPORT_61_SELECT_TEMPLATE
SELECT COALESCE(c.得意先コード,'') AS 得意先コード ,COALESCE(d.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.在庫数 ,a.仮受在庫数 ,a.出荷依頼数 ,a.在庫数 - a.出荷依頼数 AS 有効在庫数 ,COALESCE(c.単価,0) AS 単価 ,CAST(TRUNC(COALESCE(c.単価,0) * a.在庫数,0) as BIGINT) AS 在庫金額 ,CASE WHEN a.棚番2 = '' THEN a.棚番1 ELSE a.棚番1 || '-' || a.棚番2 END AS 棚番 ,CASE WHEN a.補正入数 <> 0 THEN a.補正入数 ELSE COALESCE(e.実績入数,0) END AS 入数 ,CASE WHEN a.補正入数 <> 0 THEN CEIL(a.在庫数 / a.補正入数) WHEN COALESCE(e.実績入数,0) <> 0 THEN CEIL(a.在庫数 / e.実績入数) ELSE 0 END AS 箱数 %s %s %s
-- SQL_REPORT_61_COMMON(%s1)
FROM M_在庫 AS a LEFT OUTER JOIN ( SELECT x.品番, x.設変番号, x.単価, CASE WHEN LEFT(x.得意先コード,2) = '00' THEN RIGHT(x.得意先コード,1) WHEN LEFT(x.得意先コード,1) = '0' THEN RIGHT(x.得意先コード,2) ELSE x.得意先コード END AS 得意先コード FROM ( SELECT 品番, 設変番号, MIN(単価) AS 単価, MIN(RIGHT('000' || 得意先コード, 3)) AS 得意先コード FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号 ) AS x ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = c.得意先コード LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(x.納入日) AS 納入日, MAX(COALESCE(z.個数,0)) AS 実績入数 FROM T_売上 AS x LEFT OUTER JOIN T_売上詳細 AS z ON z.管理No = x.管理No INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS e ON e.品番 = a.品番 AND e.設変番号 = a.設変番号 WHERE COALESCE(e.納入日,'9999-12-31') <= CURRENT_DATE - CAST(? || ' month' AS INTERVAL)
    -- SQL_REPORT_61_WHERE_TOKUISAKI(%s2)
    AND COALESCE(c.得意先コード,'') = ?
    -- SQL_REPORT_61_ORDERBY(%s3)
    ORDER BY COALESCE(d.表示順,0), COALESCE(c.得意先コード,''), a.品番, a.設変番号


