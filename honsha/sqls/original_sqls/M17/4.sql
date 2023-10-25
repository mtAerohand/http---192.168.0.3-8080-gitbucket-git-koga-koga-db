-- SQL_GET_ALL
SELECT 得意先コード,納入場所コード,納入場所名,表示順,有効開始日,有効終了日 FROM M_納入場所
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 得意先コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,納入場所コード
