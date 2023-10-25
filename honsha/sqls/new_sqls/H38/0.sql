-- SQL_GET_SELECT
SELECT b.management_no ,a.part_no ,a.engineering_change_no ,a.part_name ,a.stock_quantity ,a.suspense_stock_quantity ,a.ship_request_quantity ,a.bin_1 ,a.bin_2 ,a.remarks ,a.version_no ,a.packing_type FROM m_stocks AS a INNER JOIN t_incoming_orders AS b ON b.part_no = a.part_no AND b.engineering_change_no = a.engineering_change_no AND b.management_no = CAST(? AS INT)
