-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(得意先コード) AS INT) FROM M_得意先担当者
-- SQL_GET_ALL
SELECT 得意先コード,担当者コード,担当者名,表示順,有効開始日,有効終了日 FROM M_得意先担当者
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 得意先コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,担当者コード
-- SQL_GET
SELECT a.得意先コード,b.得意先名,a.担当者コード,a.有効開始日,a.有効終了日,a.担当者名,a.表示順,a.備考,a.バージョン番号FROM M_得意先担当者 AS a INNER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.得意先コード = ? AND a.担当者コード = ?
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?

