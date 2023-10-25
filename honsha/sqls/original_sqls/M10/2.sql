-- SQL_GET_ALL
SELECT a.品番, a.最新設変番号, a.品名, b.材質名, a.材質ベース単価, a.材料費, a.材料費補正額 FROM M_部品 a LEFT OUTER JOIN M_材質 b ON a.材質コード = b.材質コード
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE a.品番 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.品番


