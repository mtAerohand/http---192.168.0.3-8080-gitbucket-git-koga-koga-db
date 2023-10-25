-- SQL_REPORT_51_SELECT_TEMPLATE
SELECT a.customer_code ,COALESCE(b.customer_name,'') AS customer_name ,a.part_no ,a.engineering_change_no ,COALESCE(c.part_name,'') AS part_name ,a.notice_DATE ,CASE a.drawing_type WHEN '1' THEN '図面配布' ELSE '設変通知' END AS drawing_type ,CASE a.drawing_type WHEN '1' THEN '' ELSE a.new_engineering_change_no END AS new_engineering_change_no ,CASE a.work_instruction_type WHEN '1' THEN '工程変更' WHEN '2' THEN '製造中止' ELSE '' END AS 作業指示 ,CASE a.wip_type WHEN '1' THEN '使用可' WHEN '2' THEN '修正' WHEN '3' THEN '使用不可' ELSE '' END AS 仕掛品対処 ,COALESCE(d.supplier_code,'') AS supplier_code ,COALESCE(e.supplier_name,'') AS supplier_name ,a.issue_DATE ,d.return_DATE %s %s %s
-- SQL_REPORT_51_COMMON(%s1)
FROM t_drawings AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no LEFT OUTER JOIN t_drawing_details AS d ON d.seq_no = a.seq_no LEFT OUTER JOIN m_suppliers AS e ON e.supplier_code = d.supplier_code WHERE a.customer_code = ? AND a.notice_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_51_WHERE_HINBAN(%s2)
    AND a.part_no &^ ?
    -- SQL_REPORT_51_ORDERBY(%s3)
    ORDER BY a.part_no, a.engineering_change_no, a.notice_DATE, COALESCE(d.process_sort_no,0)


