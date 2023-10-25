-- SQL_GETPURCHASELIST_SELECT
SELECT b.part_no ,b.engineering_change_no ,a.placing_order_no ,a.supplier_code ,COALESCE(c.supplier_abbreviation,'') AS supplier_name ,a.process_code ,COALESCE(d.process_abbreviation,'') AS process_name ,a.placing_order_DATE ,a.deadline ,a.placing_order_quantity FROM t_placing_orders AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no LEFT OUTER JOIN m_suppliers AS c ON c.supplier_code = a.supplier_code LEFT OUTER JOIN m_processes AS d ON d.process_code = a.process_code WHERE b.incoming_order_no &@ ? AND LENGTH(incoming_order_no) = LENGTH(?) AND b.branch_no = ? ORDER BY a.placing_order_DATE DESC, a.process_sort_no


