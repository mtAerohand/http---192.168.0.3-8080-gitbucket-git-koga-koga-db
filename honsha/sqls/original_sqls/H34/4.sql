﻿-- SQL_GET_REQUEST
SELECT A.管理No ,A.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,A.作業区担当者名 ,A.担当者コード ,COALESCE(C.社員名,'') AS 担当者名 ,CURRENT_DATE + interval '2 day' AS 回答期限日 ,'15' AS 回答期限時刻 ,CASE WHEN COALESCE(F.コメント,'') = '' THEN 'よろしくお願い申し上げます。' ELSE F.コメント END AS コメント FROM ( /* 通常 */ SELECT 管理No ,作業区コード ,作業区担当者名 ,担当者コード FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '1' UNION ALL /* 多工程 */ SELECT c.管理No ,c.作業区コード ,c.作業区担当者名 ,c.担当者コード FROM ( SELECT 管理No ,MIN(工程順序No) AS 先頭工程順序No FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '2' GROUP BY 管理No ) AS a INNER JOIN ( SELECT 管理No ,工程順序No ,MIN(分納No) AS 先頭分納No FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '2' GROUP BY 管理No, 工程順序No ) AS b ON b.管理No = a.管理No AND b.工程順序No = a.先頭工程順序No INNER JOIN T_納期回答依頼 AS c ON c.管理No = b.管理No AND c.工程順序No = b.工程順序No AND c.分納No = b.先頭分納No ) AS A LEFT OUTER JOIN M_作業区仕入先 AS B ON B.作業区コード = A.作業区コード LEFT OUTER JOIN M_社員 AS C ON C.社員コード = A.担当者コード INNER JOIN T_受注 AS D ON D.管理No = A.管理No LEFT OUTER JOIN ( SELECT 管理No ,MAX(督促日) AS 督促日 FROM T_納期回答依頼 WHERE 督促日 IS NOT NULL GROUP BY 管理No ) AS E ON E.管理No = A.管理No LEFT OUTER JOIN ( SELECT DISTINCT 管理No ,督促日 ,コメント FROM T_納期回答依頼 ) AS F ON F.管理No = E.管理No AND F.督促日 = E.督促日 WHERE A.管理No = CAST(? AS INT)


