-- SQL_GET
SELECT a.得意先コード,b.得意先名,a.納入場所コード,a.有効開始日,a.有効終了日,a.納入場所名,a.表示順,a.備考,a.バージョン番号FROM M_納入場所 AS a INNER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.得意先コード = ? AND a.納入場所コード = ?


