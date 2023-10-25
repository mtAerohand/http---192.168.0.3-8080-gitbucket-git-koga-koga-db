-- SQL_REPORT_22_COUNT_TEMPLATE
SELECT CAST(COUNT(A.supplier_code) AS INT) %s %s
    -- SQL_REPORT_22_COMMON(%s1)
    FROM( SELECT supplier_code ,CAST(COUNT(supplier_code) AS INT) AS 発注件数 ,CAST(SUM(TRUNC(unit_price * placing_order_quantity,0)) AS BIGINT) AS 発注price FROM t_placing_orders WHERE deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) GROUP BY supplier_code ) AS A LEFT OUTER JOIN ( SELECT x.supplier_code ,CAST(COUNT(x.supplier_code) AS INT) AS 発注残件数 ,CAST(SUM(x.発注残price) AS BIGINT) AS 発注残price FROM ( SELECT a.supplier_code ,CAST(TRUNC(a.unit_price * (a.placing_order_quantity - COALESCE(b.完了数,0)),0) as BIGINT) AS 発注残price FROM t_placing_orders AS a LEFT OUTER JOIN ( SELECT placing_order_no ,SUM(acceptance_quantity) AS 完了数 FROM t_process_acceptances GROUP BY placing_order_no ) as b ON b.placing_order_no = a.placing_order_no WHERE a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM t_process_acceptances WHERE placing_order_no = a.placing_order_no AND acceptance_form_type IN ('1','2')) ) AS x GROUP BY x.supplier_code ) AS B ON B.supplier_code = A.supplier_code LEFT OUTER JOIN m_suppliers AS C ON C.supplier_code = A.supplier_code LEFT OUTER JOIN ( SELECT y.supplier_code ,CAST(SUM(y.発注残price) AS BIGINT) AS 発注残price FROM ( SELECT x.supplier_code ,CASE WHEN x.process_sort_no = 1 THEN CAST(TRUNC(x.unit_price * (x.placing_order_quantity - x.自工程完了数),0) as BIGINT) ELSE CASE WHEN x.前工程完了数 > 0 THEN CASE WHEN x.前工程完了数 > x.自工程完了数 THEN CAST(TRUNC(x.unit_price * (x.前工程完了数 - x.自工程完了数),0) as BIGINT) ELSE 0 END ELSE CASE WHEN x.自工程完了数 > 0 THEN CAST(TRUNC(x.unit_price * (x.placing_order_quantity - x.自工程完了数),0) as BIGINT) ELSE CASE WHEN x.response_DATE有無 = 1 THEN CAST(TRUNC(x.unit_price * x.placing_order_quantity,0) as BIGINT) ELSE 0 END END END END AS 発注残price FROM ( SELECT a.placing_order_no ,a.management_no ,a.process_sort_no ,a.supplier_code ,a.placing_order_DATE ,a.placing_order_quantity ,a.unit_price ,CASE WHEN EXISTS (SELECT * FROM t_deadline_response_requests WHERE management_no = a.management_no AND process_sort_no = (a.process_sort_no - 1) AND response_DATE IS NOT NULL) THEN 1 ELSE 0 END AS response_DATE有無 ,COALESCE(b.前工程完了数,0) AS 前工程完了数 ,COALESCE(c.自工程完了数,0) AS 自工程完了数 FROM t_placing_orders AS a LEFT OUTER JOIN ( SELECT management_no ,process_sort_no ,SUM(acceptance_quantity) AS 前工程完了数 FROM t_process_acceptances GROUP BY management_no, process_sort_no ) AS b ON b.management_no = a.management_no AND b.process_sort_no = (a.process_sort_no - 1) LEFT OUTER JOIN ( SELECT placing_order_no ,SUM(acceptance_quantity) AS 自工程完了数 FROM t_process_acceptances GROUP BY placing_order_no ) AS c ON c.placing_order_no = a.placing_order_no WHERE a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM t_process_acceptances WHERE placing_order_no = a.placing_order_no AND acceptance_form_type IN ('1','2')) ) AS x ) AS y GROUP BY y.supplier_code ) AS D ON D.supplier_code = A.supplier_code
    -- SQL_REPORT_22_ORDERBY(%s2)
    ORDER BY COALESCE(C.sort_no,0), A.supplier_code


