-- SQL_REPORT_14_COUNT
SELECT CAST(COUNT(x.customer_code) AS INT)
-- SQL_REPORT_14_CORE1
FROM (SELECT a.customer_code,a.incoming_order_no,a.branch_no,a.part_no,a.engineering_change_no,a.part_name,a.incoming_order_DATE,a.incoming_order_quantity,a.unit_price AS 受注unit_price,b.manufacture_cost + b.material_cost AS 原価,CASE WHEN a.unit_price <> 0 THEN CAST(TRUNC((b.manufacture_cost + b.material_cost) / a.unit_price * 100,0) as BIGINT) ELSE 0 END AS 原価率,CAST(TRUNC(a.unit_price * a.incoming_order_quantity,0) as BIGINT) AS 受注price FROM t_incoming_orders AS a INNER JOIN ( SELECT management_no ,SUM(manufacture_cost) AS manufacture_cost ,SUM(material_cost) AS material_cost FROM t_production_plan_details GROUP BY management_no ) AS b ON b.management_no = a.management_no WHERE a.incoming_order_type <> '2'
    -- SQL_REPORT_TOKUISAKI
    AND a.customer_code = ?
    -- SQL_REPORT_ZYUCHUUBI
    AND a.incoming_order_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_HINBAN
    AND a.part_no &^ ?
-- SQL_REPORT_14_CORE2
) AS x LEFT OUTER JOIN m_customers AS y ON y.customer_code = x.customer_code
    -- SQL_REPORT_GENKARITSU
    WHERE x.原価率 BETWEEN CAST(CASE WHEN ? = '' THEN '0' ELSE ? END as INT) AND CAST(CASE WHEN ? = '' THEN '100' ELSE ? END as INT)
    -- SQL_REPORT_14_ORDER_BY
    ORDER BY COALESCE(y.sort_no,0), x.customer_code, x.part_no, x.incoming_order_DATE


