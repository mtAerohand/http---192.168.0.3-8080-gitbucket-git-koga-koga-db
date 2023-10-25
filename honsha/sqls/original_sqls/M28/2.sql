-- SQL_GETALL
SELECT 品番 ,設変番号 ,品名 ,在庫数 ,仮受在庫数 ,出荷依頼数 ,在庫数 - 出荷依頼数 AS 有効在庫数 ,CASE WHEN 棚番2 = '' THEN 棚番1 ELSE 棚番1 || '-' || 棚番2 END AS 棚番 ,備考 ,補正入数 FROM M_在庫
-- SQL_GETALL_WHERE_CLAUSE
WHERE 品番 LIKE ?
-- SQL_GETALL_ORDERBY_CLAUSE
ORDER BY 品番, 設変番号


