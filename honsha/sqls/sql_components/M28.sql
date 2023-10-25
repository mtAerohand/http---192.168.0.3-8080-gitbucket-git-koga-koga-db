-- SQL_GETALL
SELECT 品番 ,設変番号 ,品名 ,在庫数 ,仮受在庫数 ,出荷依頼数 ,在庫数 - 出荷依頼数 AS 有効在庫数 ,CASE WHEN 棚番2 = '' THEN 棚番1 ELSE 棚番1 || '-' || 棚番2 END AS 棚番 ,備考 ,補正入数 FROM M_在庫
-- SQL_GETALL_COUNT
SELECT CAST(COUNT(品番) AS INT) FROM M_在庫
-- SQL_GETALL_WHERE_CLAUSE
WHERE 品番 LIKE ?
-- SQL_GETALL_ORDERBY_CLAUSE
ORDER BY 品番, 設変番号
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GET_SELECT
SELECT a.品番, a.設変番号, MAX(COALESCE(b.個数,0)) AS 実績入数 FROM T_受注 AS a LEFT OUTER JOIN T_売上詳細 AS b ON b.管理No = a.管理No WHERE a.品番 = ? AND a.設変番号 = ? GROUP BY a.品番, a.設変番号

