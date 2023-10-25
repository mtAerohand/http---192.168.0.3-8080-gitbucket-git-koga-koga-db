﻿-- SQL_GET_ALL_SELECT
SELECT x.管理No ,x.作業区コード ,COALESCE(y.作業区略称,'') AS 作業区名 ,x.作業区担当者名 ,z.受注番号 ,z.枝番 ,z.品番 ,z.設変番号 ,CASE WHEN x.依頼書種別 = '1' THEN COALESCE(t.工程略称,'') ELSE COALESCE(t.工程略称,'') || ' 他' END AS 工程名 ,x.希望納入日 ,x.連絡手段 ,CASE WHEN x.連絡手段 = '1' THEN 'メール' ELSE 'Fax' END AS 連絡手段名 ,x.依頼書種別 ,CASE WHEN x.依頼書種別 = '1' THEN '' ELSE '多工程' END AS 依頼書種別名
-- SQL_GET_ALL_FROM
FROM ( /* 通常 */ SELECT b.管理No ,b.工程順序No ,b.作業区コード ,b.作業区担当者名 ,b.希望納入日 ,b.連絡手段 ,b.依頼書種別 ,b.担当者コード FROM ( SELECT 管理No ,工程順序No ,MIN(分納No) AS 先頭分納No FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '1' GROUP BY 管理No, 工程順序No ) AS a INNER JOIN T_納期回答依頼 AS b ON b.管理No = a.管理No AND b.工程順序No = a.工程順序No AND b.分納No = a.先頭分納No UNION ALL /* 多工程 */ SELECT c.管理No ,c.工程順序No ,c.作業区コード ,c.作業区担当者名 ,c.希望納入日 ,c.連絡手段 ,c.依頼書種別 ,c.担当者コード FROM ( SELECT 管理No ,MIN(工程順序No) AS 先頭工程順序No FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '2' GROUP BY 管理No ) AS a INNER JOIN ( SELECT 管理No ,工程順序No ,MIN(分納No) AS 先頭分納No FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '2' GROUP BY 管理No, 工程順序No ) AS b ON b.管理No = a.管理No AND b.工程順序No = a.先頭工程順序No INNEr JOIN T_納期回答依頼 AS c ON c.管理No = b.管理No AND c.工程順序No = b.工程順序No AND c.分納No = b.先頭分納No ) AS x LEFT OUTER JOIN M_作業区仕入先 AS y ON y.作業区コード = x.作業区コード INNER JOIN T_受注 AS z ON z.管理No = x.管理No INNER JOIN T_生産計画詳細 AS s ON s.管理No = x.管理No AND s.工程順序No = x.工程順序No LEFT OUTER JOIN M_工程 AS t ON t.工程コード = s.工程コード WHERE x.担当者コード = ?
-- SQL_GET_ALL_ORDER
ORDER BY COALESCE(y.表示順,0), x.作業区コード, x.作業区担当者名, x.希望納入日, z.品番


