-- SQL_REPORT_41_SELECT_TEMPLATE
SELECT CASE A.区分 WHEN '1' THEN '加工' WHEN '2' THEN '加工返' WHEN '3' THEN '材料' WHEN '4' THEN '材料返' ELSE '売上' END AS 区分 ,A.supplier_code ,COALESCE(B.supplier_name,'') AS supplier_name ,A.incoming_order_no,A.branch_no,A.part_no,A.engineering_change_no,A.part_name,A.日付 ,A.quantity_or_weight,A.unit_price,A.仕入price,CASE A.acceptance_form_type WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,COALESCE(C.supplier_abbreviation,'') AS 材料仕入先名 FROM ( SELECT 1 AS 区分 ,c1.supplier_code,b1.incoming_order_no,b1.branch_no,b1.part_no,b1.engineering_change_no,b1.part_name,a1.acceptance_DATE AS 日付 ,a1.acceptance_quantity AS quantity_or_weight,a1.unit_price,a1.price AS 仕入price,a1.acceptance_form_type,'' AS 材料supplier_code FROM t_process_acceptances AS a1 INNER JOIN t_incoming_orders AS b1 ON b1.management_no = a1.management_no INNER JOIN t_placing_orders AS c1 ON c1.placing_order_no = a1.placing_order_no WHERE c1.supplier_code = ? AND a1.acceptance_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT 2 AS 区分 ,a2.supplier_code,b2.incoming_order_no,b2.branch_no,b2.part_no,b2.engineering_change_no,b2.part_name,a2.return_DATE AS 日付 ,a2.quantity AS quantity_or_weight,a2.unit_price,- a2.price AS 仕入price,'' AS acceptance_form_type,'' AS 材料supplier_code FROM t_acceptance_returns AS a2 INNER JOIN t_incoming_orders AS b2 ON b2.management_no = a2.management_no WHERE a2.supplier_code = ? AND a2.return_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT CASE WHEN a3.purchase_category_type = '1' THEN CASE WHEN a3.purchase_type = '1' THEN 3 ELSE 4 END ELSE CASE WHEN a3.purchase_type = '1' THEN 1 ELSE 2 END END AS 区分 ,a3.supplier_code AS supplier_code ,'' AS incoming_order_no ,'' AS branch_no ,CASE WHEN a3.purchase_category_type = '1' THEN a3.material_name ELSE a3.part_no END AS part_no ,CASE WHEN a3.purchase_category_type = '1' THEN '' ELSE a3.engineering_change_no END AS engineering_change_no ,CASE WHEN a3.purchase_category_type = '1' THEN a3.shape ELSE a3.part_name END AS part_name ,a3.deal_DATE AS 日付 ,CASE WHEN a3.purchase_category_type = '1' THEN a3.weight ELSE a3.quantity END AS quantity_or_weight ,a3.unit_price ,CASE WHEN a3.purchase_type = '1' THEN a3.price ELSE - a3.price END AS 仕入price ,'' AS acceptance_form_type ,CASE WHEN a3.purchase_category_type = '1' THEN a3.supply_target_code ELSE NULL END AS 材料supplier_code FROM t_purchases AS a3 WHERE a3.supplier_code = ? AND a3.deal_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT CASE WHEN a4.purchase_type = '1' THEN 3 ELSE 4 END AS 区分 ,a4.supply_target_code AS supplier_code ,'' AS incoming_order_no ,'' AS branch_no ,a4.material_name AS part_no ,'' AS engineering_change_no ,a4.shape AS part_name ,a4.deal_DATE AS 日付 ,CASE WHEN a4.purchase_type = '1' AND a4.offset_method_type = '2' THEN c4.weight ELSE a4.weight END AS quantity_or_weight ,a4.unit_price ,CASE WHEN a4.purchase_type = '1' AND a4.offset_method_type = '1' THEN - a4.supply_amount WHEN a4.purchase_type = '1' AND a4.offset_method_type = '2' THEN - c4.offset_amount ELSE a4.supply_amount END AS 仕入price ,'' AS acceptance_form_type ,a4.supplier_code AS 材料supplier_code FROM t_purchases AS a4 LEFT OUTER JOIN t_purchase_offsets AS c4 ON c4.seq_no = a4.seq_no WHERE a4.purchase_category_type = '1' AND a4.supply_target_code = ? AND CASE WHEN a4.purchase_type = '1' AND a4.offset_method_type = '2' THEN c4.offset_DATE ELSE a4.deal_DATE + interval'1 month' END BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT 5 AS 区分 ,a5.deal_code AS supplier_code ,'' AS incoming_order_no,'' AS branch_no,a5.part_no,a5.engineering_change_no,a5.part_name,a5.sales_DATE AS 日付 ,a5.quantity AS quantity_or_weight,a5.unit_price,- a5.price AS 仕入price,'' AS acceptance_form_type,'' AS 材料supplier_code FROM t_sales_options AS a5 WHERE a5.deal_type = '2' AND a5.deal_code = ? AND a5.sales_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS A LEFT OUTER JOIN m_suppliers AS B ON B.supplier_code = A.supplier_code LEFT OUTER JOIN m_suppliers AS C ON C.supplier_code = A.材料supplier_code ORDER BY A.日付, A.区分, A.part_no, A.engineering_change_no

