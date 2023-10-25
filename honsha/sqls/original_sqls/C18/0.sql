-- SQL_GET_ALL
SELECT 得意先コード,納入場所コード,納入場所名 FROM M_納入場所 WHERE 得意先コード = ? AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,納入場所コード


