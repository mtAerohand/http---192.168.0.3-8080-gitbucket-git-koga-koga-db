-- SQL_GET_SELECT
SELECT a.品番, a.設変番号, MAX(COALESCE(b.個数,0)) AS 実績入数 FROM T_受注 AS a LEFT OUTER JOIN T_売上詳細 AS b ON b.管理No = a.管理No WHERE a.品番 = ? AND a.設変番号 = ? GROUP BY a.品番, a.設変番号
