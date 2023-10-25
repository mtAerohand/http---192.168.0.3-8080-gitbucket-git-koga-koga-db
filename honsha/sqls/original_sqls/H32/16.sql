-- SQL_GET_ORDER_QUANTITY
SELECT FLOOR(COALESCE(a.受注数,0) / 6) AS 月平均 ,COALESCE(b.受注数,0) AS 年合計 FROM ( SELECT SUM(受注数) AS 受注数 FROM T_受注 WHERE 納期 BETWEEN CURRENT_DATE - interval '6 month' AND CURRENT_DATE - interval '1 day' AND 受注区分 IN ('2','3') AND LEFT(受注番号,8) = ? ) AS a CROSS JOIN ( SELECT SUM(受注数) AS 受注数 FROM T_受注 WHERE 納期 BETWEEN CURRENT_DATE - interval '1 year' AND CURRENT_DATE - interval '1 day' AND 受注区分 IN ('2','3') AND LEFT(受注番号,8) = ? ) AS b


