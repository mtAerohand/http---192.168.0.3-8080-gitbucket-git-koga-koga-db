BACKORDER =
SELECT
  a.supplier_code,
  COALESCE(c.supplier_name,'') AS supplier_name,
  CASE RTRIM(b.branch_no)
    WHEN '' THEN b.incoming_order_no
    ELSE b.incoming_order_no || ' (' || RTRIM(b.branch_no) || ')'
  END AS 表示incoming_order_no,
  CASE RTRIM(b.engineering_change_no)
    WHEN '' THEN b.part_no
    WHEN '0' THEN b.part_no
    WHEN '00' THEN b.part_no
    ELSE b.part_no || ' (' || RTRIM(b.engineering_change_no) || ')'
  END AS 表示part_no,
  a.placing_order_DATE AS incoming_order_DATE,
  a.deadline,
  d.response_DATE,
  a.placing_order_quantity AS incoming_order_quantity,
  a.unit_price,
  CAST(FLOOR(a.unit_price * a.placing_order_quantity) as BIGINT) AS 受注price,
  CASE WHEN e.plan_no IS NULL THEN '' ELSE '済' END AS 計画,
  COALESCE(g.supplier_name,'') AS 前工程supplier_name,
  f.deadline AS 前工程deadline,
  h.response_DATE AS 前工程response_DATE,
  i.acceptance_DATE AS 前工程納品日,
  COALESCE(j.acceptance_quantity,0) AS 前工程納品数
FROM 本社DB.t_placing_orders AS a
INNER JOIN 本社DB.t_incoming_orders AS b
ON b.management_no = a.management_no
LEFT OUTER JOIN 本社DB.m_suppliers AS c
ON c.supplier_code = a.supplier_code
LEFT OUTER JOIN (
  SELECT management_no, process_sort_no, MIN(response_DATE) AS response_DATE
  FROM 本社DB.t_deadline_response_requests
  GROUP BY management_no, process_sort_no
) AS d
ON d.management_no = a.management_no
AND d.process_sort_no = a.process_sort_no
LEFT OUTER JOIN (
  SELECT placing_order_no,MIN(plan_no) AS plan_no
  FROM m_process_plans
  GROUP BY placing_order_no
) AS e
ON e.placing_order_no = CAST(a.placing_order_no as VARCHAR(6))
LEFT OUTER JOIN 本社DB.t_production_plan_details AS f
ON f.management_no = a.management_no
AND f.process_sort_no = (a.process_sort_no - 1)
LEFT OUTER JOIN 本社DB.m_suppliers AS g
ON g.supplier_code = f.supplier_code
LEFT OUTER JOIN (
  SELECT management_no, process_sort_no, MIN(response_DATE) AS response_DATE
  FROM 本社DB.t_deadline_response_requests
  GROUP BY management_no, process_sort_no
) AS h
ON h.management_no = f.management_no
AND h.process_sort_no = f.process_sort_no
LEFT OUTER JOIN (
  SELECT management_no, process_sort_no, MIN(acceptance_DATE) AS acceptance_DATE
  FROM 本社DB.t_process_acceptances
  GROUP BY management_no, process_sort_no
) AS i
ON i.management_no = f.management_no
AND i.process_sort_no = f.process_sort_no
LEFT OUTER JOIN 本社DB.t_process_acceptances AS j
ON j.management_no = i.management_no
AND j.process_sort_no = i.process_sort_no
AND j.acceptance_DATE = i.acceptance_DATE
WHERE NOT EXISTS (SELECT * FROM 本社DB.t_process_acceptances WHERE management_no = a.management_no AND process_sort_no = a.process_sort_no AND acceptance_form_type IN ('1','2'))
AND a.supplier_code = ?
AND a.placing_order_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
ORDER BY 表示part_no, a.placing_order_DATE, a.deadline;
