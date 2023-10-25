-- SQL_GET
SELECT a.seq_no ,a.subject ,a.content ,a.contact_DATE ,a.upDATEr_code ,b.employee_name FROM m_notices AS a LEFT OUTER JOIN m_employees AS b ON b.employee_code = a.upDATEr_code ORDER BY a.contact_DATE DESC LIMIT 1
