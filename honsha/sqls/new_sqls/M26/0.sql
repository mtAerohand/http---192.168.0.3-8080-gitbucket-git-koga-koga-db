-- SQL_GET_ALL
SELECT a.seq_no,a.subject,a.contact_DATE,a.upDATEr_code,b.employee_name FROM m_notices AS a LEFT OUTER JOIN m_employees AS b ON b.employee_code = a.upDATEr_code WHERE a.contact_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) ORDER BY a.contact_DATE DESC
