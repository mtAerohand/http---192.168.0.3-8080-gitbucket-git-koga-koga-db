-- SQL_GET
SELECT 管理No ,受注番号 ,枝番 ,CASE WHEN 客先品番 = '' THEN 品番 ELSE 客先品番 END AS 品番 ,設変番号 ,品名FROM T_受注WHERE 管理No =CAST(? as INT)

