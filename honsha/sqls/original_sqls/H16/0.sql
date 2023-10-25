-- SQL_GET_PURCHASE
SELECT a.伝票番号 ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.品名 ,a.作業区コード ,COALESCE(d.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(e.工程名,'') AS 工程名 ,a.発注日 ,a.納期 ,a.発注数 ,a.発注数 - COALESCE(c.受入数,0) AS 発注残数 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN ( SELECT 伝票番号 ,SUM(受入数) AS 受入数 FROM T_工程受入 GROUP BY 伝票番号 ) AS c ON c.伝票番号 = a.伝票番号 LEFT OUTER JOIN M_作業区仕入先 AS d ON d.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS e ON e.工程コード = a.工程コード
-- SQL_GET_PURCHASE_WHERE_CLAUSE_CHECK_NO
WHERE a.伝票番号 = CAST(? AS INT)


