-- SQL_REPORT
SELECT a.seq_no, a.drawing_type, a.part_no, COALESCE(c.part_name,'') AS part_name, a.engineering_change_no, a.new_engineering_change_no, a.requested_return_DATE, a.remarks, b.supplier_code, COALESCE(d.supplier_name,'') AS supplier_name FROM t_drawings AS a INNER JOIN t_drawing_details AS b ON b.seq_no = a.seq_no AND b.return_DATE IS NULL LEFT OUTER JOIN m_parts AS c ON c.part_no = a.part_no LEFT OUTER JOIN m_suppliers AS d ON d.supplier_code = b.supplier_code WHERE a.seq_no = ? AND a.is_output = true ORDER BY b.process_sort_no


