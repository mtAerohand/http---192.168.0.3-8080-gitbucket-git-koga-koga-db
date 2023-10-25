-- SQL_CHECK_EXISTS_REQUEST
SELECT CASE WHEN EXISTS (SELECT * FROM t_test_and_ship_requests WHERE management_no = CAST(? as INT) AND test_type = true AND test_result_type IN ('1','2') AND delivery_form_type IN ('1','2','4','11','12') ) THEN 1 /* 完了依頼有り */ ELSE CASE WHEN EXISTS (SELECT * FROM t_sales WHERE management_no = CAST(? as INT) AND delivery_form_type IN ('1','2','4') ) THEN 1 /* 完了依頼有り */ ELSE 0 /* 完了依頼無し */ END END AS 判定


