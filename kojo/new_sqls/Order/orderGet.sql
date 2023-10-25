GET_BY_ORDER_NUMBER =
SELECT DISTINCT
incoming_order_no, branch_no, incoming_order_id_no, placing_order_no, part_no, engineering_change_no, part_name, incoming_order_DATE
, deadline, incoming_order_quantity, supplier_code, supplier_name漢字, process_code, process_name略,
 COALESCE(
(
SELECT
MIN(response_DATE)
FROM V_工場受注情報 AS a
WHERE
a.placing_order_no = b.placing_order_no
AND
response_DATE <> ''
GROUP BY placing_order_no
), '') as response_DATE
FROM
V_工場受注情報 AS b
WHERE
placing_order_no = ?;
