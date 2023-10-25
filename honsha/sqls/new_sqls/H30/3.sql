-- SQL_CREATE_REPORT_DETAIL_SELECT
SELECT a.deal_DATE, a.incoming_order_no, a.branch_no, a.part_no_material, a.engineering_change_no , a.detail_type, a.quantity_or_weight, a.unit_price, a.price, a.remarks FROM t_acceptance_test_details a
-- SQL_CREATE_REPORT_DETAIL_WHERE
WHERE a.payment_month = ? AND a.supplier_code = ?
-- SQL_CREATE_REPORT_DETAIL_ORDER
ORDER BY a.deal_DATE, a.part_no_material
