-- SQL_GET_ALL
SELECT 得意先コード ,次工程コード ,次工程名 FROM M_次工程 WHERE 得意先コード = ? AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,次工程コード
-- SQL_GET
SELECT a.得意先コード ,a.次工程コード ,a.次工程名 ,CASE WHEN b.請求元 IS NULL THEN '' ELSE b.バケット情報 END AS 納入バケット FROM M_次工程 AS a LEFT OUTER JOIN M_納入バケット AS b ON b.次工程コード = a.次工程コード AND CURRENT_TIMESTAMP BETWEEN b.有効開始日 AND b.有効終了日 AND b.請求元 = ? WHERE CURRENT_DATE BETWEEN a.有効開始日 AND a.有効終了日 AND a.得意先コード = ? AND a.次工程コード = ?

