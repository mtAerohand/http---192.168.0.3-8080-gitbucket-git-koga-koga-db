-- SQL_REPORT_33_SELECT_TEMPLATE
SELECT x.biller ,CAST(COUNT(x.biller) AS INT) AS 件数 ,SUM(x.price) AS 売上price ,SUM(x.箱数) AS 箱数 ,SUM(x.袋数) AS 袋数 %s %s
-- SQL_REPORT_33_COMMON(%s1)
FROM ( SELECT b.biller ,a.price ,CASE WHEN a.packing_unit = '1' THEN COALESCE(e.packing_quantity,0) ELSE 0 END AS 箱数 ,CASE WHEN a.packing_unit = '1' THEN 0 ELSE COALESCE(e.packing_quantity,0) END AS 袋数 FROM t_sales AS a INNER JOIN t_incoming_orders AS b ON b.management_no = a.management_no AND b.customer_code = '1' AND b.incoming_order_type IN ('2','3') LEFT OUTER JOIN ( SELECT management_no ,partial_delivery_no ,SUM(packing_quantity) AS packing_quantity FROM t_sales_details GROUP BY management_no, partial_delivery_no ) AS e ON e.management_no = a.management_no AND e.partial_delivery_no = a.partial_delivery_no WHERE a.delivery_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS x WHERE x.biller <> '' GROUP BY x.biller
    -- SQL_REPORT_33_ORDERBY(%s2)
    ORDER BY x.biller


