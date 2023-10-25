-- SQL_GET_HISTORY_LIST
SELECT a.管理No ,a.受注番号 ,a.枝番 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '3' THEN '受注' ELSE '' END AS 受注区分 ,a.品番 ,a.設変番号 ,b.登録日 AS 計画作成日 ,b.生産数 ,c.発注単価合計 ,d.作業区コード ,COALESCE(e.作業区略称,'') ,d.工程コード ,COALESCE(f.工程略称,'') FROM T_受注 AS a INNER JOIN T_生産計画 AS b ON b.管理No = a.管理No INNER JOIN ( SELECT 管理No, SUM(加工費 + 材料費) AS 発注単価合計 FROM T_生産計画詳細 GROUP BY 管理No ) AS c ON c.管理No = b.管理No INNER JOIN T_生産計画詳細 AS d ON d.管理No = b.管理No AND 工程順序No = 1 LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = d.工程コード WHERE a.品番 = ? AND a.受注区分 IN ('1','3') ORDER BY b.登録日 DESC, a.受注番号


