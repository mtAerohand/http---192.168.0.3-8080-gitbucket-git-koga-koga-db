﻿-- SQL_REPORT_BUNNOU_HACCHUU
SELECT a.管理No,a.作業区コード,COALESCE(b.作業区名,'') AS 作業区名,a.発注日,a.納期,c.品番,c.設変番号,c.品名,c.受注番号,c.枝番,a.工程コード,COALESCE(d.工程名,'') AS 工程名,COALESCE(f.作業区名,'') AS 前工程作業区名,e.納期 AS 前工程納期,CASE WHEN g.作業区コード IS NULL THEN '古河（本社）' ELSE COALESCE(h.作業区名,'') END AS 次工程作業区名,a.伝票番号,(a.発注数 - k.受入数) AS 発注数,c.単位,a.単価 AS 発注単価,CAST(trunc(a.単価 * (a.発注数 - k.受入数),0) as BIGINT) AS 発注金額,c.発注備考1,c.発注備考2,COALESCE(i.社員名,'') AS 担当者名,CASE WHEN l.品番 IS NULL THEN '0' ELSE '1' END AS 管理マーク,CASE WHEN c.受注区分 <> '4' THEN '0' ELSE '1' END AS 再納マーク,CASE c.再納区分 WHEN '1' THEN '不合格選別依頼' WHEN '2' THEN '不合格再処理' WHEN '3' THEN '不合格再製造' ELSE '' END AS 再納マーク種類 FROM T_発注 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード INNER JOIN T_受注 AS c ON c.管理No = a.管理No LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード LEFT OUTER JOIN T_生産計画詳細 AS e ON e.管理No = a.管理No AND e.工程順序No = (a.工程順序No - 1) LEFT OUTER JOIN M_作業区仕入先 AS f ON f.作業区コード = e.作業区コード LEFT OUTER JOIN T_生産計画詳細 AS g ON g.管理No = a.管理No AND g.工程順序No = (a.工程順序No + 1) LEFT OUTER JOIN M_作業区仕入先 AS h ON h.作業区コード = g.作業区コード LEFT OUTER JOIN M_社員 AS i ON i.社員コード = c.担当者コード INNER JOIN (SELECT 管理No, 工程順序No, SUM(受入数) AS 受入数 FROM T_工程受入 GROUP BY 管理No, 工程順序No) AS k ON k.管理No = a.管理No AND k.工程順序No = a.工程順序No LEFT OUTER JOIN ( SELECT DISTINCT 品番 FROM T_図面 WHERE 図面種類 = '1' ) AS l ON l.品番 = c.品番 WHERE a.管理No = CAST(? AS INT) AND a.工程順序No = CAST(? AS INT) ORDER BY a.管理No, a.工程順序No

