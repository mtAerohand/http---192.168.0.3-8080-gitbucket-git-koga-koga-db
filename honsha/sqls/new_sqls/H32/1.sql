-- SQL_GET_ALL
SELECT a.management_no ,a.incoming_order_no ,a.branch_no ,a.part_no ,a.engineering_change_no ,a.incoming_order_DATE ,a.deadline ,CASE a.incoming_order_type WHEN '1' THEN '1' /* 先行手配 */ WHEN '2' THEN '0' /* 受注（計画無し） */ WHEN '3' THEN '1' /* 受注（計画有り） */ ELSE '1' /* 再納 */ END AS production_quantity表示 ,COALESCE(b.production_quantity,0) AS production_quantity ,CASE a.incoming_order_type WHEN '1' THEN '0' /* 先行手配 */ WHEN '2' THEN '1' /* 受注（計画無し） */ WHEN '3' THEN '1' /* 受注（計画有り） */ ELSE '0' /* 再納 */ END AS incoming_order_quantity表示 ,a.incoming_order_quantity ,CASE WHEN a.incoming_order_type IN ('1','4') /* 先行手配, 再納 */ THEN CASE WHEN d.management_no IS NULL /* 依頼無し */ THEN '' /* 依頼有り */ ELSE CASE WHEN d.test_type = false /* test無し */ THEN CASE d.delivery_form_type WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '??' END /* test有り */ ELSE CASE d.test_result_type /* 未test */ WHEN '0' THEN '依頼中' /* 合格 */ WHEN '1' THEN CASE d.delivery_form_type WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '' END /* 不合格 */ WHEN '2' THEN '不合格' ELSE '??' END END END /* 受注（計画無し）,受注（計画有り）,再納 */ ELSE CASE WHEN d.management_no IS NULL /* 依頼無し */ THEN '' /* 依頼有り */ ELSE CASE WHEN d.test_result_type = '2' /* 不合格 */ THEN '不合格' /* 不合格以外 */ ELSE CASE WHEN e.management_no IS NULL /* 売上無し */ THEN '依頼中' /* 売上有り */ ELSE CASE e.delivery_form_type WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' ELSE '??' END END END END END AS 状況 ,CASE WHEN a.incoming_order_type IN ('1','4') /* 先行手配, 再納 */ THEN CASE WHEN d.management_no IS NULL /* 依頼無し */ THEN NULL /* 依頼有り */ ELSE CASE WHEN d.test_type = false /* test無し */ THEN CASE d.delivery_form_type WHEN '11' THEN d.request_DATE WHEN '12' THEN d.request_DATE WHEN '13' THEN NULL ELSE NULL END /* test有り */ ELSE CASE d.test_result_type /* 未test */ WHEN '0' THEN NULL /* 合格 */ WHEN '1' THEN CASE d.delivery_form_type WHEN '11' THEN d.result_registration_DATE WHEN '12' THEN d.result_registration_DATE WHEN '13' THEN NULL ELSE NULL END /* 不合格 */ WHEN '2' THEN d.result_registration_DATE ELSE NULL END END END /* 受注（計画無し）,受注（計画有り）,再納 */ ELSE CASE WHEN d.management_no IS NULL /* 依頼無し */ THEN NULL /* 依頼有り */ ELSE CASE WHEN d.test_result_type = '2' /* 不合格 */ THEN d.result_registration_DATE /* 不合格以外 */ ELSE CASE WHEN e.management_no IS NULL /* 売上無し */ THEN NULL /* 売上有り */ ELSE CASE e.delivery_form_type WHEN '1' THEN e.delivery_DATE WHEN '2' THEN e.delivery_DATE WHEN '3' THEN NULL WHEN '4' THEN e.delivery_DATE ELSE NULL END END END END END AS 完了日 ,a.manager_code ,COALESCE(f.employee_name,'') AS manager_name ,a.customer_code ,CASE WHEN a.customer_code = '1' THEN '1' ELSE '0' END as 得意先区分 ,CASE WHEN a.incoming_order_data_type = '' THEN '0' /* 伝送以外(black) */ ELSE CASE WHEN a.data_upDATE_type = false THEN '1' /* 未更新(red) */ ELSE '2' /* 更新済み(blue) */ END END AS 色区分 ,d.request_DATE
-- SQL_GET_ALL_FROM_CLAUSE
FROM t_incoming_orders AS a LEFT OUTER JOIN t_production_plans AS b ON b.management_no = a.management_no LEFT OUTER JOIN ( SELECT management_no, MAX(partial_delivery_no) AS partial_delivery_no FROM t_test_and_ship_requests GROUP BY management_no ) AS c ON c.management_no = a.management_no LEFT OUTER JOIN t_test_and_ship_requests AS d ON d.management_no = c.management_no AND d.partial_delivery_no = c.partial_delivery_no LEFT OUTER JOIN t_sales AS e ON e.management_no = d.management_no AND e.partial_delivery_no = d.partial_delivery_no LEFT OUTER JOIN m_employees AS f ON f.employee_code = a.manager_code
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    WHERE a.incoming_order_no &@ ? AND LENGTH(a.incoming_order_no) = LENGTH(?) /*「incoming_order_no」指定時 */
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.deadline DESC, a.incoming_order_no DESC, a.branch_no DESC

    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    WHERE a.part_no &@ ? AND LENGTH(a.part_no) = LENGTH(?) /*「part_no」指定時 */
        -- SQL_GET_ALL_WHERE_CLAUSE_SETTING_NO
        AND a.engineering_change_no = ? /*「engineering_change_no」も同時に指定時 */
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.deadline DESC, a.incoming_order_no DESC, a.branch_no DESC

