-- SQL_GET_SELECT
SELECT a.part_no, a.engineering_change_no, MAX(COALESCE(b.quantity,0)) AS 実績quantity FROM t_incoming_orders AS a LEFT OUTER JOIN t_sales_details AS b ON b.management_no = a.management_no WHERE a.part_no = ? AND a.engineering_change_no = ? GROUP BY a.part_no, a.engineering_change_no
