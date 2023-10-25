-- SQL_GETHISTORYLIST_SELECT
SELECT a.inventory_month FROM ( SELECT DISTINCT inventory_month FROM t_inventories ) AS a ORDER BY a.inventory_month DESC LIMIT 3


