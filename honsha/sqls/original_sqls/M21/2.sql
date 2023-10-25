-- SQL_GET_ALL
SELECT 材質コード,材質名,比重,表示順,有効開始日,有効終了日 FROM M_材質
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE 材質名 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,材質コード
