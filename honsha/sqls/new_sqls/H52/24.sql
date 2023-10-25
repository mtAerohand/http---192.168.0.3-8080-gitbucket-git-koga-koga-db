-- SQL_REPORT_11_SELECT
SELECT a.management_no, a.customer_code, COALESCE(b.customer_name,'') AS customer_name, a.incoming_order_no, a.branch_no, a.part_no, a.engineering_change_no, a.part_name, a.customer_part_no, a.incoming_order_DATE, a.deadline, a.incoming_order_quantity, a.unit_price, CASE COALESCE(b.price_round_type,'1') WHEN '1' THEN CAST(FLOOR(a.unit_price * a.incoming_order_quantity) as BIGINT) WHEN '2' THEN CAST(CEIL(a.unit_price * a.incoming_order_quantity) as BIGINT) ELSE CAST(ROUND((a.unit_price * a.incoming_order_quantity),0) as BIGINT) END AS 受注price,a.biller ,a.delivery_place_name ,a.next_process_name
-- SQL_REPORT_11_CORE
FROM t_incoming_orders AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code WHERE a.incoming_order_type IN ('2','3')
    -- SQL_REPORT_TOKUISAKI
    AND a.customer_code = ?
    -- SQL_REPORT_ZYUCHUUBI
    AND a.incoming_order_DATE BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_NOUKI
    AND a.deadline BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_HINBAN
    AND a.part_no &^ ?
    -- SQL_REPORT_11_ORDER_BY
    ORDER BY COALESCE(b.sort_no,0), a.customer_code, a.part_no, a.incoming_order_DATE


