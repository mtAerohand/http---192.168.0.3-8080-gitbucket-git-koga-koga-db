-- SQL_GET_PLAN_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM t_production_plans WHERE management_no = ?) THEN 1 ELSE 0 END AS 判定


