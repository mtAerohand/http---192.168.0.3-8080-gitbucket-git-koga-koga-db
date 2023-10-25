-- SQL_GET_PURCHASE
SELECT a.伝票番号 ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.品名 ,a.作業区コード ,COALESCE(d.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(e.工程名,'') AS 工程名 ,a.発注日 ,a.納期 ,a.発注数 ,a.発注数 - COALESCE(c.受入数,0) AS 発注残数 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN ( SELECT 伝票番号 ,SUM(受入数) AS 受入数 FROM T_工程受入 GROUP BY 伝票番号 ) AS c ON c.伝票番号 = a.伝票番号 LEFT OUTER JOIN M_作業区仕入先 AS d ON d.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS e ON e.工程コード = a.工程コード
-- SQL_GET_PURCHASE_WHERE_CLAUSE_CHECK_NO
WHERE a.伝票番号 = CAST(? AS INT)
-- SQL_GET_ALL
SELECT a.伝票番号 ,a.分納No ,a.受入日 ,a.受入数 ,a.受入形態区分 ,CASE a.受入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,a.単価 ,a.金額 FROM T_工程受入 AS a
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.分納No
-- SQL_GET_PURCHASE_LIST
SELECT a.伝票番号 ,a.作業区コード ,COALESCE(c.作業区略称,'') AS 作業区名 ,a.工程コード ,COALESCE(d.工程略称,'') AS 工程名 ,a.発注日 ,a.納期 ,a.発注数 ,b.受注番号 ,b.枝番 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード WHERE b.品番 &@ ? AND LENGTH(b.品番) = LENGTH(?) AND b.設変番号 = ? AND NOT EXISTS (SELECT * FROM T_検査出荷依頼 WHERE 管理No = a.管理No AND 納入形態区分 IN ('1','2','4','11','12')) ORDER BY a.発注日 DESC, a.管理No, a.工程順序No
-- SQL_GET_PROCESS
SELECT a.伝票番号 ,a.管理No ,a.工程順序No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.品名 ,a.作業区コード ,COALESCE(e.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(f.工程名,'') AS 工程名 ,a.発注日 ,a.納期 ,a.最終工程区分 ,COALESCE(c.分納No,1) AS 分納No ,COALESCE(c.受入日,CURRENT_DATE) AS 受入日 ,a.発注数 ,a.発注数 - COALESCE(d.総受入数,0) AS 発注残数 ,c.受入数 ,COALESCE(c.受入形態区分,'1') AS 受入形態区分 ,c.単価 ,c.金額 ,c.バージョン番号 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN T_工程受入 AS c ON c.伝票番号 = a.伝票番号 AND c.分納No = CAST(? AS INT) LEFT OUTER JOIN ( SELECT 伝票番号,SUM(受入数) AS 総受入数 FROM T_工程受入 GROUP BY 伝票番号) AS d ON d.伝票番号 = a.伝票番号 LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = a.工程コード WHERE a.伝票番号 = CAST(? AS INT)
-- SQL_LAST_ACCEPTANCE_DAY_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM T_工程受入 WHERE 伝票番号 = ? AND 分納No <> ? AND 受入日 >= CAST(? as DATE)) THEN 1 ELSE 0 END AS 判定
-- SQL_BEFORE_TIME_FOR_DELIVERY_ORDER
SELECT CASE WHEN EXISTS( SELECT * FROM ( SELECT a.作業区コード ,a.納期 ,b.品番 ,b.設変番号 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.伝票番号 = CAST(? AS INT) ) AS x INNER JOIN ( SELECT a.作業区コード ,a.納期 ,b.品番 ,b.設変番号 FROM T_受注 AS b INNER JOIN T_発注 AS a ON a.管理No = b.管理No WHERE NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No AND 受入形態区分 IN ('1','2')) ) AS y ON y.品番 = x.品番 AND y.設変番号 = x.設変番号 AND y.作業区コード = x.作業区コード AND y.納期 < x.納期 ) THEN 1 ELSE 0 END AS 判定
-- SQL_BEFORE_PROCESS_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM T_工程受入 WHERE 管理No = CAST(? AS INT) AND 工程順序No = (CAST(? AS INT) - 1)) THEN 1 ELSE 0 END AS 判定
-- SQL_BEFORE_PROCESS_COUNT
SELECT 受入数 FROM T_工程受入 WHERE 管理No = CAST(? AS INT) AND 工程順序No = (CAST(? AS INT) - 1) AND 分納No = CAST(? AS INT)

