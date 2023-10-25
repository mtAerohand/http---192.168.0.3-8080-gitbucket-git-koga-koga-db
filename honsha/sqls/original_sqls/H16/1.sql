-- SQL_GET_ALL
SELECT a.伝票番号 ,a.分納No ,a.受入日 ,a.受入数 ,a.受入形態区分 ,CASE a.受入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,a.単価 ,a.金額 FROM T_工程受入 AS a
-- SQL_GET_PURCHASE_WHERE_CLAUSE_CHECK_NO
WHERE a.伝票番号 = CAST(? AS INT)
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.分納No


