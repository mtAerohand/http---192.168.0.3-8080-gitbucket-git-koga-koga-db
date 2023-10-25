-- SQL_GET_ALL
SELECT supplier_code,supplier_name,CASE type WHEN '1' THEN '作業区' ELSE '材料仕入先' END AS type,CASE supplier_type WHEN '1' THEN '自社' WHEN '2' THEN '協力会社' ELSE '' END AS supplier_type,CASE acceptance_report_type WHEN true THEN '有り' ELSE '無し' END AS acceptance_report_type,CASE payment_method_type WHEN '1' THEN '現金' WHEN '2' THEN '手形' WHEN '3' THEN 'その他' ELSE '' END AS payment_method_type,CASE demand_contact_method_type WHEN '1' THEN 'メール' WHEN '2' THEN 'Fax' ELSE '' END AS demand_contact_method_type,sort_no,valid_start_DATE,valid_end_DATE ,CASE partial_order_issue_type WHEN true THEN '有り' ELSE '無し' END AS partial_order_issue_type FROM m_suppliers
    -- SQL_GET_ALL_WHERE_CLAUSE_DIVISION
    WHERE supplier_code = ?
    
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE type = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY sort_no,supplier_code


