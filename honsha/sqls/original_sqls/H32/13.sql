-- SQL_GET_STOCK
SELECT 品番 ,設変番号 ,在庫数 ,仮受在庫数 ,出荷依頼数 ,在庫数 - 出荷依頼数 AS 有効在庫数 FROM M_在庫 WHERE 品番 = ? AND 設変番号 = ?


