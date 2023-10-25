-- SQL_SELECT
SELECT a.seq_no ,b.incoming_order_no ,b.branch_no ,b.part_no ,b.engineering_change_no ,a.box_no ,a.quantity ,a.ship_quantity ,a.print_DATE ,a.item_tag_barcode_no ,c.send_data_create_DATE ,a.version_no
-- SQL_WHERE
FROM t_item_tags AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN ( SELECT data_seq_no ,MAX(send_data_create_DATE) AS send_data_create_DATE FROM t_smc_send_parameters WHERE data_type_code = 1 GROUP BY data_seq_no ) AS c ON c.data_seq_no = a.seq_no WHERE a.valid_type = false AND a.print_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_WHERE_OPTION1
    AND c.send_data_create_DATE IS NULL
    
    -- SQL_WHERE_OPTION2
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)
-- SQL_ORDER_BY
ORDER BY a.item_tag_barcode_no


