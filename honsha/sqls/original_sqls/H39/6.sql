-- SQL_GETPURCHASE_SELECT
SELECT b.材質名 ,b.形状 ,b.単価 ,b.取引日 ,b.重量 FROM (SELECT 材質名, 形状, MAX(取引日) AS 取引日 FROM T_仕入 WHERE 取引区分 = '1' AND 取引分類 = '1' AND 材質名 = ? AND 形状 = ? GROUP BY 材質名, 形状) AS a INNER JOIN T_仕入 AS b ON b.材質名 = a.材質名 AND b.形状 = a.形状 AND b.取引日 = a.取引日 LIMIT 1


