-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(作業区コード) AS INT) FROM M_作業区担当者 WHERE 作業区コード= ?
-- SQL_GET_ALL
SELECT 作業区コード,担当者コード,担当者名,メールアドレス,ユーザID,パスワード,CASE 権限 WHEN '1' THEN '一般' WHEN '2' THEN '管理者' ELSE '' END AS 権限,表示順,有効開始日,有効終了日 FROM M_作業区担当者 WHERE 作業区コード = ? ORDER BY 表示順, 担当者コード
-- SQL_GET
SELECT a.作業区コード,b.作業区名,a.担当者コード,a.担当者名,a.メールアドレス,a.ユーザID,a.パスワード,a.権限,a.表示順,a.有効開始日,a.有効終了日,a.備考,a.バージョン番号 FROM M_作業区担当者 AS a INNER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.作業区コード = ? AND a.担当者コード = ?
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_PLACES
SELECT CASE WHEN EXISTS(SELECT * FROM M_作業区担当者 WHERE 作業区コード = ? AND 担当者コード = ?) THEN 1 ELSE 0 END AS 判定
-- SQL_ADD_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM M_作業区担当者 WHERE ユーザID = ?) THEN 1 ELSE 0 END AS 判定
-- SQL_UPDATE_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM M_作業区担当者 WHERE ユーザID = ? AND NOT (作業区コード = ? AND 担当者コード = ?)) THEN 1 ELSE 0 END AS 判定
-- SQL_GET_ONE
SELECT a.作業区コード ,b.作業区名 ,a.担当者コード ,a.担当者名 ,a.メールアドレス ,a.ユーザID ,a.パスワード ,a.権限 ,a.表示順 ,a.有効開始日 ,a.有効終了日 ,a.備考 ,a.バージョン番号 FROM M_作業区担当者 AS a INNER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.作業区コード = ? ORDER BY a.表示順, a.担当者コード LIMIT 1

