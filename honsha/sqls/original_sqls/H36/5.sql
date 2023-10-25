-- SQL_GET_WORKREGION_SELECT
SELECT B.作業区コード, COALESCE(C.作業区略称,'') AS 作業区名 FROM ( SELECT b.管理No FROM ( SELECT 品番, MAX(受注日) AS 受注日 FROM T_受注 AS x WHERE 品番 = ? AND EXISTS (SELECT * FROM T_生産計画 WHERE 管理No = x.管理No) GROUP BY 品番 ) AS a INNER JOIN T_受注 AS b ON b.品番 = a.品番 AND b.受注日 = a.受注日 AND EXISTS (SELECT * FROM T_生産計画 WHERE 管理No = b.管理No) LIMIT 1 ) AS A INNER JOIN T_生産計画詳細 AS B ON B.管理No = A.管理No LEFT OUTER JOIN M_作業区仕入先 AS C ON C.作業区コード = B.作業区コード ORDER BY B.工程順序No


