-- SQL_BEFORE_TIME_FOR_DELIVERY_ORDER
SELECT CASE WHEN EXISTS( SELECT * FROM ( SELECT a.supplier_code ,a.deadline ,b.part_no ,b.engineering_change_no FROM t_placing_orders AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no WHERE a.placing_order_no = CAST(? AS INT) ) AS x INNER JOIN ( SELECT a.supplier_code ,a.deadline ,b.part_no ,b.engineering_change_no FROM t_incoming_orders AS b INNER JOIN t_placing_orders AS a ON a.management_no = b.management_no WHERE NOT EXISTS (SELECT * FROM t_process_acceptances WHERE management_no = a.management_no AND process_sort_no = a.process_sort_no AND acceptance_form_type IN ('1','2')) ) AS y ON y.part_no = x.part_no AND y.engineering_change_no = x.engineering_change_no AND y.supplier_code = x.supplier_code AND y.deadline < x.deadline ) THEN 1 ELSE 0 END AS 判定


