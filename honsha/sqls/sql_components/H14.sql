﻿-- SQL_GET_ALL
SELECT a.SeqNo ,a.受注番号符号 || TO_CHAR(a.登録日, 'YYMMDD') || '-' AS 受注番号 ,a.品番 ,a.設変番号 ,a.納期 ,a.生産数 ,CASE a.督促区分 WHEN true THEN '有' ELSE '' END AS 督促有無 ,a.備考 ,a.担当者コード ,COALESCE(b.社員名,'') AS 担当者名 ,c.管理No FROM T_先行手配 AS a LEFT OUTER JOIN M_社員 AS b ON b.社員コード = a.担当者コード LEFT OUTER JOIN ( SELECT 品番 ,設変番号 ,MAX(管理No) AS 管理No FROM T_受注 WHERE 受注区分 = '1' GROUP BY 品番, 設変番号 ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 WHERE a.登録日 = CAST(? as DATE) ORDER BY a.品番, a.分納No

