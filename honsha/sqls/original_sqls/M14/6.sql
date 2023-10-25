-- SQL_GET_ALL
SELECT 作業区コード,担当者コード,担当者名,メールアドレス,ユーザID,パスワード,CASE 権限 WHEN '1' THEN '一般' WHEN '2' THEN '管理者' ELSE '' END AS 権限,表示順,有効開始日,有効終了日 FROM M_作業区担当者 WHERE 作業区コード = ? ORDER BY 表示順, 担当者コード


