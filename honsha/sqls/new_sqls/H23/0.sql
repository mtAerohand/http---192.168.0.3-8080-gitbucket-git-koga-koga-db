-- SQL_GET
SELECT management_no ,incoming_order_no ,branch_no ,CASE WHEN customer_part_no = '' THEN part_no ELSE customer_part_no END AS part_no ,engineering_change_no ,part_nameFROM t_incoming_ordersWHERE management_no =CAST(? as INT)
