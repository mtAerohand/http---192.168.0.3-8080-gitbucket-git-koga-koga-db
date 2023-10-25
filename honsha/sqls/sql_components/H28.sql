-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.SeqNo) AS INT) FROM T_受入返品 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_生産計画詳細 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No INNER JOIN T_発注 AS d ON d.管理No = a.管理No AND d.工程順序No = a.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = c.工程コード
-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.作業区コード ,COALESCE(e.作業区略称,'') AS 作業区名 ,a.返品日 ,a.管理No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,a.工程順序No ,c.工程コード ,COALESCE(f.工程略称,'') AS 工程名 ,d.伝票番号 ,a.数量 ,a.返品書発行日 FROM T_受入返品 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_生産計画詳細 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No INNER JOIN T_発注 AS d ON d.管理No = a.管理No AND d.工程順序No = a.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = c.工程コード
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.返品日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_HENPINSAKI
AND a.作業区コード = ?
-- SQL_GETALL_WHERE_SEQNO
WHERE a.SeqNo = CAST(? AS INT)
-- SQL_GETALL_ORDERBY
ORDER BY a.返品日 DESC, b.受注番号, b.枝番, a.工程順序No
-- SQL_GETPURCHASELIST_SELECT
SELECT b.品番 ,b.設変番号 ,a.伝票番号 ,a.作業区コード ,COALESCE(c.作業区略称,'') AS 作業区名 ,a.工程コード ,COALESCE(d.工程略称,'') AS 工程名 ,a.発注日 ,a.納期 ,a.発注数 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード WHERE b.受注番号 &@ ? AND LENGTH(受注番号) = LENGTH(?) AND b.枝番 = ? ORDER BY a.発注日 DESC, a.工程順序No
-- SQL_GETPURCHASE_SELECT
SELECT a.伝票番号 ,a.管理No ,a.工程順序No ,b.受注番号 ,b.枝番 ,a.作業区コード ,COALESCE(c.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(d.工程名,'') AS 工程名 ,a.発注日 ,a.納期 ,b.品番 ,b.設変番号 ,b.品名 ,a.発注数 ,a.単価 ,CAST(trunc(a.単価 * a.発注数 ,0) as BIGINT) AS 発注金額 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード WHERE a.伝票番号 = CAST(? AS INT)
-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM T_受入返品 WHERE 返品日 = CAST(? as DATE) AND 管理No = CAST(? AS INT) AND 工程順序No = CAST(? AS INT) %s ) THEN 1 ELSE 0 END AS 判定
-- SQL_EXISTS_WHERE_UPDATE
AND SeqNo <> CAST(? AS INT)

