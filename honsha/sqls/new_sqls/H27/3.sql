-- SQL_GETALL_COUNT
SELECT CAST(COUNT(seq_no) AS INT) FROM t_purchases AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.purchase_type = '2'
-- SQL_GETALL_WHERE_HENPINBI
AND a.deal_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GETALL_WHERE_HENPINSAKI
    AND a.supplier_code = ?


