-- SQL_GETORDER_SELECT
SELECT b.part_no ,b.engineering_change_no ,b.unit_price ,b.incoming_order_DATE ,b.incoming_order_quantity FROM (SELECT part_no, engineering_change_no, MAX(incoming_order_DATE) AS incoming_order_DATE FROM t_incoming_orders WHERE part_no = ? AND engineering_change_no = ? GROUP BY part_no, engineering_change_no) AS a INNER JOIN t_incoming_orders AS b ON b.part_no = a.part_no AND b.engineering_change_no = a.engineering_change_no AND b.incoming_order_DATE = a.incoming_order_DATE LIMIT 1


