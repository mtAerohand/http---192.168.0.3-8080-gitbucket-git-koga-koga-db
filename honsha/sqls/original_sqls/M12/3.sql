-- SQL_GET_ALL
SELECT 得意先コード,担当者コード,担当者名,表示順,有効開始日,有効終了日 FROM M_得意先担当者
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 得意先コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,担当者コード
