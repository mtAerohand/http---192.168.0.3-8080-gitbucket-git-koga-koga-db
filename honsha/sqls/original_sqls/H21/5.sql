﻿-- SQL_GENPINHYOU_SMC
SELECT a.管理No,a.分納No,a.納入日,b.請求元,b.受注番号,CASE WHEN b.客先品番 = '' THEN b.品番 ELSE b.客先品番 END AS 品番,b.設変番号,b.品名,b.次工程名,e.納入場所名,CASE b.注文データ区分 WHEN 'A' THEN COALESCE(c.棚番,'') WHEN 'K' THEN COALESCE(d.棚番,'') WHEN 'C' THEN COALESCE(d.棚番,'') ELSE ''END AS 棚番,CASE b.注文データ区分 WHEN 'A' THEN CASE WHEN LENGTH(COALESCE(c.管理番号,'')) < 15 THEN SUBSTRING(COALESCE(c.管理番号,''), 4, 15) ELSE COALESCE(c.工号,'') END WHEN 'K' THEN COALESCE(d.工号,'') WHEN 'C' THEN COALESCE(d.工号,'') ELSE ''END AS 工号,g.個数計,g.梱包数計,CASE WHEN a.梱包単位 = '1' THEN '箱' ELSE '袋' END AS 梱包単位,f.個数,f.梱包数,b.テーパーおねじ区分 FROM T_売上 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN T_購買伝票受注 AS c ON c.帳票番号 = b.注文バーコード番号 LEFT OUTER JOIN T_工号生産納入指示 AS d ON d.発行連番 = b.注文バーコード番号 INNER JOIN T_検査出荷依頼 AS e ON e.管理No = a.管理No AND e.分納No = a.分納No INNER JOIN T_売上詳細 AS f ON f.管理No = a.管理No AND f.分納No = a.分納No INNER JOIN ( SELECT 管理No ,分納No ,SUM(個数 * 梱包数) AS 個数計 ,SUM(梱包数) AS 梱包数計 FROM T_売上詳細 GROUP BY 管理No, 分納No ) AS g ON g.管理No = a.管理No AND g.分納No = a.分納No WHERE a.管理No = CAST(? as INT) AND a.分納No = CAST(? as INT) ORDER BY f.SeqNo

