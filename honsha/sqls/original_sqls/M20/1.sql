-- SQL_GET
SELECT a.請求元,a.次工程コード,COALESCE(b.次工程名,'') AS 次工程名,a.バケット情報,a.有効開始日,a.有効終了日,a.備考,a.バージョン番号 FROM M_納入バケット AS a LEFT OUTER JOIN M_次工程 AS b ON b.次工程コード = a.次工程コード AND b.得意先コード = '1' WHERE a.請求元 = ? AND a.次工程コード = ?


