-- SQL_CHECK_FOR_DUPLICATE_ORDER_NUMBER
SELECT CAST(COUNT(management_no) AS INT) AS 件数 FROM t_incoming_orders WHERE incoming_order_type = ? AND incoming_order_no = ? AND branch_no = ?


