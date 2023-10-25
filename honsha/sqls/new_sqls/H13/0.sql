-- SQL_BASE
SELECT a.management_no ,a.incoming_order_no ,a.branch_no ,a.part_no ,a.engineering_change_no ,a.part_name ,a.incoming_order_DATE ,a.deadline ,a.incoming_order_quantity ,a.manager_code ,COALESCE(b.employee_name,'') AS manager_name ,a.incoming_order_report_output_DATE ,a.incoming_order_comment ,CASE WHEN c.incoming_order_DATE IS NULL THEN '無' ELSE '有' END AS 先行手配有無 ,CASE a.incoming_order_data_type WHEN 'A' THEN '1' ELSE '2' END AS 注文書種別 ,a.incoming_order_barcode_no ,a.version_no ,CASE WHEN EXISTS (SELECT * FROM t_sales WHERE management_no = a.management_no) THEN '1' ELSE '0' END AS 売上区分 FROM t_incoming_orders AS a LEFT OUTER JOIN m_employees AS b ON b.employee_code = a.manager_code LEFT OUTER JOIN ( SELECT DISTINCT incoming_order_DATE, part_no, engineering_change_no FROM t_preceding_arrangements ) AS c ON c.incoming_order_DATE = a.incoming_order_DATE AND c.part_no = a.part_no AND c.engineering_change_no = a.engineering_change_no WHERE a.incoming_order_type = '2' AND a.incoming_order_data_type <> '' AND a.registration_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_ORDER
    AND a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?)
    -- SQL_PARTS
    AND a.part_no &@ ? AND LENGTH(a.part_no) = LENGTH(?)
    -- SQL_ONCE
    AND a.management_no = CAST(? as INT)
-- SQL_BY
ORDER BY a.registration_DATE, a.part_no


