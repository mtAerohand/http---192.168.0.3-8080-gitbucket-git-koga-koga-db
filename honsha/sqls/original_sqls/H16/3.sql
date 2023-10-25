-- SQL_GET_PROCESS
SELECT a.伝票番号 ,a.管理No ,a.工程順序No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.品名 ,a.作業区コード ,COALESCE(e.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(f.工程名,'') AS 工程名 ,a.発注日 ,a.納期 ,a.最終工程区分 ,COALESCE(c.分納No,1) AS 分納No ,COALESCE(c.受入日,CURRENT_DATE) AS 受入日 ,a.発注数 ,a.発注数 - COALESCE(d.総受入数,0) AS 発注残数 ,c.受入数 ,COALESCE(c.受入形態区分,'1') AS 受入形態区分 ,c.単価 ,c.金額 ,c.バージョン番号 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN T_工程受入 AS c ON c.伝票番号 = a.伝票番号 AND c.分納No = CAST(? AS INT) LEFT OUTER JOIN ( SELECT 伝票番号,SUM(受入数) AS 総受入数 FROM T_工程受入 GROUP BY 伝票番号) AS d ON d.伝票番号 = a.伝票番号 LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = a.工程コード WHERE a.伝票番号 = CAST(? AS INT)


