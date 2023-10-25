-- SQL_GET_STOCK
SELECT part_no ,engineering_change_no ,stock_quantity ,suspense_stock_quantity ,ship_request_quantity ,stock_quantity - ship_request_quantity AS 有効stock_quantity FROM m_stocks WHERE part_no = ? AND engineering_change_no = ?


