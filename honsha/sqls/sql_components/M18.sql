-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(得意先コード) AS INT) FROM M_次工程
-- SQL_GET_ALL
SELECT 得意先コード,次工程コード,次工程名,表示順,有効開始日,有効終了日 FROM M_次工程
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 得意先コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,次工程コード
-- SQL_GET
SELECT a.得意先コード,b.得意先名,a.次工程コード,a.有効開始日,a.有効終了日,a.次工程名,a.表示順,a.備考,a.バージョン番号FROM M_次工程 AS a INNER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.得意先コード = ? AND a.次工程コード = ?
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_PLACES
SELECT CASE WHEN EXISTS(SELECT * FROM M_次工程 WHERE 得意先コード = ? AND 次工程コード = ?) THEN 1 ELSE 0 END AS 判定

