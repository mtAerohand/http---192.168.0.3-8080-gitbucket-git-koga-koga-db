-- SQL_REPORT_44_SELECT_TEMPLATE
SELECT a.supplier_code AS supply_target_code ,COALESCE(b.supplier_name, '') AS 支給先 ,a.年月 ,a.件数 ,a.price ,a.消費税 %s %s %s
-- SQL_REPORT_44_COMMON
FROM ( SELECT c.supplier_code ,c.年月 ,CAST(COUNT(c.supplier_code) as BIGINT) AS 件数 ,CAST(SUM(c.price) as BIGINT) AS price ,CAST(ROUND((SUM(c.price)*0.1),0) as BIGINT) AS 消費税 FROM ( SELECT d.supply_target_code AS supplier_code ,CASE WHEN d.purchase_type = '1' AND d.offset_method_type = '2' THEN TO_CHAR(e.offset_DATE,'YYYY/MM') ELSE TO_CHAR(d.deal_DATE +interval '1 month' ,'YYYY/MM') END AS 年月 ,CASE WHEN d.purchase_type = '1' AND d.offset_method_type = '1' THEN d.supply_amount WHEN d.purchase_type = '1' AND d.offset_method_type = '2' THEN e.offset_amount ELSE - d.supply_amount END AS price FROM t_purchases d LEFT OUTER JOIN t_purchase_offsets AS e ON e.seq_no = d.seq_no WHERE d.purchase_category_type = '1' AND CASE WHEN d.purchase_type = '1' AND d.offset_method_type = '2' THEN e.offset_DATE ELSE d.deal_DATE + interval'1 month' END BETWEEN CAST(? as DATE) AND (CAST(? as DATE) + interval '1 month' ) - interval '1 day' UNION ALL SELECT f.deal_code AS supplier_code ,TO_CHAR(f.sales_DATE,'YYYY/MM') AS 年月 ,f.price FROM t_sales_options AS f WHERE f.deal_type = '2' AND f.sales_DATE BETWEEN CAST(? as DATE) AND (CAST(? as DATE) + interval '1 month' ) - interval '1 day' ) AS c GROUP BY c.supplier_code, c.年月 ) AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE b.acceptance_report_type = true
    -- SQL_REPORT_44_WHERE_SAGYOUKU
    AND a.supplier_code = ?
    -- SQL_REPORT_44_ORDERBY
    ORDER BY a.supplier_code, a.年月


