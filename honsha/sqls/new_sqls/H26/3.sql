-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.seq_no) AS INT) FROM t_purchases AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supply_target_code WHERE a.purchase_type = '1' AND a.supplier_code = ? AND a.deal_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)


