-- SQL_GETORDER_SELECT
SELECT b.品番 ,b.設変番号 ,b.単価 ,b.受注日 ,b.受注数 FROM (SELECT 品番, 設変番号, MAX(受注日) AS 受注日 FROM T_受注 WHERE 品番 = ? AND 設変番号 = ? GROUP BY 品番, 設変番号) AS a INNER JOIN T_受注 AS b ON b.品番 = a.品番 AND b.設変番号 = a.設変番号 AND b.受注日 = a.受注日 LIMIT 1


