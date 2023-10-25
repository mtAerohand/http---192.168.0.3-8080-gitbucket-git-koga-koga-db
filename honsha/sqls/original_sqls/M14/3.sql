-- SQL_GET
SELECT a.作業区コード,b.作業区名,a.担当者コード,a.担当者名,a.メールアドレス,a.ユーザID,a.パスワード,a.権限,a.表示順,a.有効開始日,a.有効終了日,a.備考,a.バージョン番号 FROM M_作業区担当者 AS a INNER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.作業区コード = ? AND a.担当者コード = ?


