-- SQL_GETPURCHASE_SELECT
SELECT a.伝票番号 ,a.管理No ,a.工程順序No ,b.受注番号 ,b.枝番 ,a.作業区コード ,COALESCE(c.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(d.工程名,'') AS 工程名 ,a.発注日 ,a.納期 ,b.品番 ,b.設変番号 ,b.品名 ,a.発注数 ,a.単価 ,CAST(trunc(a.単価 * a.発注数 ,0) as BIGINT) AS 発注金額 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード WHERE a.伝票番号 = CAST(? AS INT)


