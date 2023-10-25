-- SQL_REPORT
SELECT a.管理No ,a.分納No ,b.受注番号 ,b.品番 ,b.設変番号 ,b.品名 ,a.予定納入数 ,a.回答日 ,a.FAX備考 ,a.バージョン番号 FROM T_納期回答 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.FAX作成 = true AND CAST(b.得意先コード AS INT) = ? AND CAST(a.担当者コード AS INT) = ? AND a.得意先担当者名 = ? ORDER BY a.回答日, b.受注番号