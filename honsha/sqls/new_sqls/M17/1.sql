-- SQL_GET
SELECT a.customer_code,b.customer_name,a.delivery_place_code,a.valid_start_DATE,a.valid_end_DATE,a.delivery_place_name,a.sort_no,a.remarks,a.version_noFROM m_delivery_places AS a INNER JOIN m_customers AS b ON b.customer_code = a.customer_code
-- SQL_GET_WHERE_CLAUSE
WHERE a.customer_code = ? AND a.delivery_place_code = ?


