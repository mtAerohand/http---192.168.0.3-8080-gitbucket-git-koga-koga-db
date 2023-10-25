-- SQL_GET_ALL
SELECT 工程コード,工程名,工程略称,表示順,有効開始日,有効終了日 FROM M_工程
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE 工程名 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,工程コード


