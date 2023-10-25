-- SQL_GET_MAIL
SELECT A.管理No ,A.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,A.作業区担当者コード ,A.作業区担当者名 ,C.メールアドレス AS 作業区担当者メールアドレス ,A.担当者コード ,COALESCE(D.社員名,'') AS 担当者名 ,COALESCE(D.メールアドレス,'') AS 担当者メールアドレス ,E.受注番号 ,E.品番 ,E.設変番号 ,E.枝番 FROM ( SELECT DISTINCT 管理No ,作業区コード ,作業区担当者コード ,作業区担当者名 ,担当者コード FROM T_納期回答依頼 WHERE 回答依頼作成 = true AND 依頼書種別 = '1' AND 連絡手段 = '1' ) AS A LEFT OUTER JOIN M_作業区仕入先 AS B ON B.作業区コード = A.作業区コード LEFT OUTER JOIN M_作業区担当者 AS C ON C.作業区コード = A.作業区コード AND C.担当者コード = A.作業区担当者コード LEFT OUTER JOIN M_社員 AS D ON D.社員コード = A.担当者コード INNER JOIN T_受注 AS E ON E.管理No = A.管理No WHERE A.管理No
-- H34/578
IN (?)
-- SQL_GET_MAIL_ORDER
ORDER BY E.品番, E.設変番号


