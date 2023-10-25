-- SQL_GET_ORDERPLACED
SELECT a.伝票番号 ,a.管理No ,a.工程順序No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.品名 ,c.作業区名 ,d.工程名 ,a.発注日 ,a.納期 ,a.発注数 ,a.単価 ,CAST(trunc(a.単価 * a.発注数 ,0) as BIGINT) AS 金額 ,a.最終工程区分 ,CASE WHEN e.加工費区分 = true OR e.材料費区分 = true THEN 1 ELSE 0 END AS 単価区分 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード INNER JOIN T_生産計画詳細 AS e ON e.管理No = a.管理No AND e.工程順序No = a.工程順序No WHERE a.伝票番号 = CAST(? as INT) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 伝票番号 = a.伝票番号)


