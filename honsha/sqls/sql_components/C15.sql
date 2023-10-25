-- SQL_GET_ALL
SELECT a.作業区コード,b.作業区名,a.担当者コード,a.担当者名,a.メールアドレス FROM M_作業区担当者 AS a INNER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.作業区コード
-- SQL_AFTER_IN_CLAUSE
AND CURRENT_DATE BETWEEN a.有効開始日 AND a.有効終了日 ORDER BY b.表示順,a.作業区コード,a.表示順,a.担当者コード

