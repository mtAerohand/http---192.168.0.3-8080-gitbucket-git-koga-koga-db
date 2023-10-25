-- SQL_GETALL_SELECT_COUNT
SELECT CAST(COUNT(seq_no) AS INT) FROM t_inventories
    -- SQL_GETALL_WHERE_TANAOROSHI
    WHERE inventory_month = ? AND supplier_code = ?
    
    -- SQL_GETALL_WHERE_seq_no
    WHERE seq_no = CAST(? AS INT)


