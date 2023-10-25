-- SQL_GET_PARTS_BY_ORDER
SELECT DISTINCT part_no FROM t_incoming_orders WHERE incoming_order_no &@ ? AND LENGTH(incoming_order_no) = LENGTH(?)


