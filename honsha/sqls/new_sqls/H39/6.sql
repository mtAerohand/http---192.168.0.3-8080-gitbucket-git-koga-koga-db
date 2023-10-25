-- SQL_GETPURCHASE_SELECT
SELECT b.material_name ,b.shape ,b.unit_price ,b.deal_DATE ,b.weight FROM (SELECT material_name, shape, MAX(deal_DATE) AS deal_DATE FROM t_purchases WHERE purchase_type = '1' AND purchase_category_type = '1' AND material_name = ? AND shape = ? GROUP BY material_name, shape) AS a INNER JOIN t_purchases AS b ON b.material_name = a.material_name AND b.shape = a.shape AND b.deal_DATE = a.deal_DATE LIMIT 1


