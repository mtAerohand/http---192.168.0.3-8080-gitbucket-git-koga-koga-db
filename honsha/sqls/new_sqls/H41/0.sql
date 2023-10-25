-- SQL_SELECT_COUNT
SELECT CAST(COUNT(a.seq_no) AS INT)
-- SQL_WHERE
FROM t_item_tags AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN ( SELECT data_seq_no ,MAX(send_data_create_DATE) AS send_data_create_DATE FROM t_smc_send_parameters WHERE data_type_code = 1 GROUP BY data_seq_no ) AS c ON c.data_seq_no = a.seq_no WHERE a.valid_type = false AND a.print_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_WHERE_OPTION1
    AND c.send_data_create_DATE IS NULL
    
    -- SQL_WHERE_OPTION2
    AND b.incoming_order_no &@ ? AND LENGTH(b.incoming_order_no) = LENGTH(?)


