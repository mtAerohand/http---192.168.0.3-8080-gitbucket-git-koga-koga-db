-- SQL_GET
SELECT a.customer_code,b.customer_name,a.next_process_code,a.valid_start_DATE,a.valid_end_DATE,a.next_process_name,a.sort_no,a.remarks,a.version_noFROM m_next_processes AS a INNER JOIN m_customers AS b ON b.customer_code = a.customer_code
-- SQL_GET_WHERE_CLAUSE
WHERE a.customer_code = ? AND a.next_process_code = ?


