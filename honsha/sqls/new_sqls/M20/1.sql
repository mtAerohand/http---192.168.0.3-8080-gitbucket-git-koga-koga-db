-- SQL_GET
SELECT a.biller,a.next_process_code,COALESCE(b.next_process_name,'') AS next_process_name,a.bucket_infomation,a.valid_start_DATE,a.valid_end_DATE,a.remarks,a.version_no FROM m_delivery_buckets AS a LEFT OUTER JOIN m_next_processes AS b ON b.next_process_code = a.next_process_code AND b.customer_code = '1' WHERE a.biller = ? AND a.next_process_code = ?


