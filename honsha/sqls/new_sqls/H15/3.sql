-- SQL_REPORT_HENPIN
SELECT a.management_no, a.supplier_code, COALESCE(b.supplier_name,'') AS supplier_name, a.placing_order_DATE, a.deadline, c.part_no, c.engineering_change_no, c.part_name, c.incoming_order_no, c.branch_no, a.process_code, COALESCE(d.process_name,'') AS process_name, COALESCE(f.supplier_name,'') AS 前工程supplier_name, e.deadline AS 前工程deadline, CASE WHEN g.supplier_code IS NULL THEN '古河（本社）' ELSE COALESCE(h.supplier_name,'') END AS 次工程supplier_name, a.placing_order_no, k.quantity AS 返品数, c.unit, k.unit_price AS 返品unit_price,CAST(trunc(k.unit_price * k.quantity ,0) as BIGINT) AS 返品price, k.remarks AS 返品remarks_1, 'return_DATE：' || TO_CHAR(k.return_DATE, 'YYYY/MM/DD') AS 返品remarks_2, COALESCE(i.employee_name,'') AS manager_name, CASE WHEN l.part_no IS NULL THEN '0' ELSE '1' END AS 管理マーク, CASE WHEN c.incoming_order_type <> '4' THEN '0' ELSE '1' END AS 再納マーク, CASE c.redelivery_type WHEN '1' THEN '不合格選別依頼' WHEN '2' THEN '不合格再処理' WHEN '3' THEN '不合格再製造' ELSE '' END AS 再納マーク種類 FROM t_acceptance_returns AS k INNER JOIN t_placing_orders AS a ON k.management_no = a.management_no AND k.process_sort_no = a.process_sort_no LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code INNER JOIN t_incoming_orders AS c ON c.management_no = a.management_no LEFT OUTER JOIN m_processes AS d ON d.process_code = a.process_code LEFT OUTER JOIN t_production_plan_details AS e ON e.management_no = a.management_no AND e.process_sort_no = (a.process_sort_no - 1) LEFT OUTER JOIN m_suppliers AS f ON f.supplier_code = e.supplier_code LEFT OUTER JOIN t_production_plan_details AS g ON g.management_no = a.management_no AND g.process_sort_no = (a.process_sort_no + 1) LEFT OUTER JOIN m_suppliers AS h ON h.supplier_code = g.supplier_code LEFT OUTER JOIN m_employees AS i ON i.employee_code = c.manager_code LEFT OUTER JOIN ( SELECT DISTINCT part_no FROM t_drawings WHERE drawing_type = '1' ) AS l ON l.part_no = c.part_no WHERE k.seq_no = CAST(? AS INT) ORDER BY a.management_no, a.process_sort_no


