-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.management_no) AS INT)
-- SQL_GET_ALL_FROM_CLAUSE
FROM t_incoming_orders AS a LEFT OUTER JOIN t_production_plans AS b ON b.management_no = a.management_no LEFT OUTER JOIN ( SELECT management_no, MAX(partial_delivery_no) AS partial_delivery_no FROM t_test_and_ship_requests GROUP BY management_no ) AS c ON c.management_no = a.management_no LEFT OUTER JOIN t_test_and_ship_requests AS d ON d.management_no = c.management_no AND d.partial_delivery_no = c.partial_delivery_no LEFT OUTER JOIN t_sales AS e ON e.management_no = d.management_no AND e.partial_delivery_no = d.partial_delivery_no LEFT OUTER JOIN m_employees AS f ON f.employee_code = a.manager_code
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    WHERE a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?) /*「incoming_order_no」指定時 */

    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    WHERE a.part_no &@ ? AND LENGTH(a.part_no) = LENGTH(?) /*「part_no」指定時 */

        -- SQL_GET_ALL_WHERE_CLAUSE_SETTING_NO
        AND a.engineering_change_no = ? /*「engineering_change_no」も同時に指定時 */


