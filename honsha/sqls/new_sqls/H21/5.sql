-- SQL_GENPINHYOU_SMC
SELECT a.management_no,a.partial_delivery_no,a.delivery_DATE,b.biller,b.incoming_order_no,CASE WHEN b.customer_part_no = '' THEN b.part_no ELSE b.customer_part_no END AS part_no,b.engineering_change_no,b.part_name,b.next_process_name,e.delivery_place_name,CASE b.incoming_order_data_type WHEN 'A' THEN COALESCE(c.bin,'') WHEN 'K' THEN COALESCE(d.bin,'') WHEN 'C' THEN COALESCE(d.bin,'') ELSE ''END AS bin,CASE b.incoming_order_data_type WHEN 'A' THEN CASE WHEN LENGTH(COALESCE(c.management_no,'')) < 15 THEN SUBSTRING(COALESCE(c.management_no,''), 4, 15) ELSE COALESCE(c.kogo,'') END WHEN 'K' THEN COALESCE(d.kogo,'') WHEN 'C' THEN COALESCE(d.kogo,'') ELSE ''END AS kogo,g.quantity計,g.packing_quantity計,CASE WHEN a.packing_unit = '1' THEN '箱' ELSE '袋' END AS packing_unit,f.quantity,f.packing_quantity,b.tapered_screw_type FROM t_sales AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN t_kobai_juchu AS c ON c.report_no = b.incoming_order_barcode_no LEFT OUTER JOIN t_kogo AS d ON d.issue_INT AUTO_INCREMENT_no = b.incoming_order_barcode_no INNER JOIN t_test_and_ship_requests AS e ON e.management_no = a.management_no AND e.partial_delivery_no = a.partial_delivery_no INNER JOIN t_sales_details AS f ON f.management_no = a.management_no AND f.partial_delivery_no = a.partial_delivery_no INNER JOIN ( SELECT management_no ,partial_delivery_no ,SUM(quantity * packing_quantity) AS quantity計 ,SUM(packing_quantity) AS packing_quantity計 FROM t_sales_details GROUP BY management_no, partial_delivery_no ) AS g ON g.management_no = a.management_no AND g.partial_delivery_no = a.partial_delivery_no WHERE a.management_no = CAST(? as INT) AND a.partial_delivery_no = CAST(? as INT) ORDER BY f.seq_no


