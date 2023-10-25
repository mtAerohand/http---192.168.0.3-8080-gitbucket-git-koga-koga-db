-- SQL_GENPINHYOU_ZISYA
SELECT a.管理No ,a.分納No ,a.納入日 ,b.受注番号 ,CASE WHEN b.客先品番 = '' THEN b.品番 ELSE b.客先品番 END AS 品番 ,b.設変番号 ,b.品名 ,c.納入場所名 ,a.現品票備考 ,e.個数計 ,e.梱包数計 ,CASE WHEN a.梱包単位 = '1' THEN '箱' ELSE '袋' END AS 梱包単位 ,d.個数 ,d.梱包数 FROM T_売上 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_検査出荷依頼 AS c ON c.管理No = a.管理No AND c.分納No = a.分納No INNER JOIN T_売上詳細 AS d ON d.管理No = a.管理No AND d.分納No = a.分納No INNER JOIN ( SELECT 管理No ,分納No ,SUM(個数 * 梱包数) AS 個数計 ,SUM(梱包数) AS 梱包数計 FROM T_売上詳細 GROUP BY 管理No, 分納No ) AS e ON e.管理No = a.管理No AND e.分納No = a.分納No WHERE a.管理No = CAST(? as INT) AND a.分納No = CAST(? as INT) ORDER BY d.SeqNo


