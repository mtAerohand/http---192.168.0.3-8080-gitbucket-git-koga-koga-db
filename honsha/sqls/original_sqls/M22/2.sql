-- SQL_GET_ALL
SELECT 材料形状コード,材料形状名,増値設定,形状増値,表示順,有効開始日,有効終了日 FROM M_材料形状
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE 材料形状名 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,材料形状コード
