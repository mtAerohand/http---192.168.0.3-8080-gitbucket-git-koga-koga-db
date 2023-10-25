GET_DELIVERY_SELF =
SELECT incoming_order_no,branch_no,deadline,incoming_order_quantity,part_no,engineering_change_no,part_name,response_DATE,回答納品数,納品日,納品数
FROM V_工場受注情報
WHERE placing_order_no = ?
AND (response_DATE <> '' OR 納品日 <> '')
ORDER BY cast(partial_delivery_no AS numeric);

GET_DELIVERY_PRIOR =
SELECT K.incoming_order_no,K.branch_no,K.deadline,K.incoming_order_quantity,K.part_no,K.engineering_change_no,K.part_name,K2.response_DATE,K2.回答納品数,K2.納品日,K2.納品数
FROM
(
    SELECT DISTINCT incoming_order_no,branch_no,incoming_order_id_no,placing_order_no,management_no,part_no,engineering_change_no,part_name,deadline,incoming_order_quantity,前process_code
    FROM V_工場受注情報
) AS K
INNER JOIN V_工場受注情報 AS K2
ON K2.management_no = K.management_no
AND K2.supplier_code = K.前process_code
AND cast(K2.incoming_order_id_no AS numeric) = cast(K.incoming_order_id_no AS numeric) - 1
AND (K2.response_DATE <> '' OR K2.納品日 <> '')
WHERE K.placing_order_no = ?
ORDER BY cast(K2.partial_delivery_no AS numeric);

LISTORDER_PREFIX =
SELECT * FROM (
SELECT a.supplier_code, b.incoming_order_no, b.branch_no, CASE RTRIM(b.branch_no)
WHEN '' THEN b.incoming_order_no
ELSE b.incoming_order_no || ' (' || RTRIM(b.branch_no) || ')'
END AS 表示incoming_order_no
, CAST(a.placing_order_no as VARCHAR(6)) AS placing_order_no
, b.part_no AS part_no
, b.engineering_change_no
, CASE RTRIM(b.engineering_change_no)
WHEN ''   THEN b.part_no
WHEN '0'  THEN b.part_no
WHEN '00' THEN b.part_no
ELSE b.part_no || ' (' || RTRIM(b.engineering_change_no) || ')'
END AS 表示part_no
, b.part_name AS part_name
, COALESCE(c.process_abbreviation,'') AS process_name略
, a.placing_order_quantity AS incoming_order_quantity
, TO_CHAR(a.placing_order_DATE,'YYYYMMDD') AS incoming_order_DATE
, TO_CHAR(a.deadline,'YYYYMMDD') AS deadline
, COALESCE(TO_CHAR(d.response_DATE,'YYYYMMDD'), '') AS response_DATE
, CASE WHEN e.plan_no IS NULL THEN '0' ELSE '1' END AS 計画区分
, COALESCE(e.plan_no, 0) AS plan_no
, CASE WHEN f.management_no IS NULL THEN '0' ELSE '1' END AS 納品区分
, COALESCE(h.supplier_abbreviation,'') AS 前工程supplier_name略名
, COALESCE(TO_CHAR(g.deadline,'YYYYMMDD'),'') AS 前工程deadline
, COALESCE(TO_CHAR(i.response_DATE,'YYYYMMDD'),'') AS 前工程response_DATE
, COALESCE(TO_CHAR(j.acceptance_DATE,'YYYYMMDD'),'') AS 前工程納品日
, COALESCE(k.acceptance_quantity,0) AS 前工程納品数
FROM 本社DB.t_placing_orders AS a
INNER JOIN 本社DB.t_incoming_orders AS b
ON b.management_no = a.management_no
LEFT OUTER JOIN 本社DB.m_processes AS c
ON c.process_code = a.process_code
LEFT OUTER JOIN (
SELECT management_no
, process_sort_no
, MIN(response_DATE) AS response_DATE
FROM 本社DB.t_deadline_response_requests
WHERE response_DATE IS NOT NULL
GROUP BY management_no, process_sort_no
) AS d
ON d.management_no = a.management_no
AND d.process_sort_no = a.process_sort_no
LEFT OUTER JOIN (
SELECT placing_order_no
, MIN(plan_no) AS plan_no
FROM m_process_plans
GROUP BY placing_order_no
) AS e
ON e.placing_order_no = CAST(a.placing_order_no as VARCHAR(6))
LEFT OUTER JOIN (
SELECT DISTINCT management_no
, process_sort_no
FROM 本社DB.t_process_acceptances
WHERE acceptance_form_type IN ('1','2')
) AS f
ON f.management_no = a.management_no
AND f.process_sort_no = a.process_sort_no
LEFT OUTER JOIN 本社DB.t_production_plan_details AS g
ON g.management_no = a.management_no
AND g.process_sort_no = (a.process_sort_no - 1)
LEFT OUTER JOIN 本社DB.m_suppliers AS h
ON h.supplier_code = g.supplier_code
LEFT OUTER JOIN (
SELECT management_no
, process_sort_no
, MIN(response_DATE) AS response_DATE
FROM 本社DB.t_deadline_response_requests
WHERE response_DATE IS NOT NULL
GROUP BY management_no, process_sort_no
) AS i
ON i.management_no = g.management_no
AND i.process_sort_no = g.process_sort_no
LEFT OUTER JOIN (
SELECT management_no
, process_sort_no
, MIN(acceptance_DATE) AS acceptance_DATE
FROM 本社DB.t_process_acceptances
GROUP BY management_no, process_sort_no
) AS j
ON j.management_no = g.management_no
AND j.process_sort_no = g.process_sort_no
LEFT OUTER JOIN 本社DB.t_process_acceptances AS k
ON k.management_no = j.management_no
AND k.process_sort_no = j.process_sort_no
AND k.acceptance_DATE = j.acceptance_DATE
) AS L
WHERE L.supplier_code = ?
AND L.incoming_order_DATE BETWEEN ? AND ?;
