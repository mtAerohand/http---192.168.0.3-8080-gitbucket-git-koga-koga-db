-- SQL_GET_REPLY
SELECT a.管理No ,a.分納No ,a.回答日区分 ,a.回答日 ,a.予定納入数 ,a.FAX作成 ,a.FAX備考 ,a.発行日 ,c.得意先コード ,a.得意先担当者名 ,a.担当者コード ,COALESCE(b.社員名,'') AS 担当者名 FROM T_納期回答 AS a INNER JOIN T_受注 AS c ON c.管理No = a.管理No LEFT OUTER JOIN M_社員 AS b ON b.社員コード = a.担当者コード WHERE a.管理No = CAST(? as INT) ORDER BY a.分納No


