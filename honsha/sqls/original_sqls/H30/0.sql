-- SQL_GETALL_SELECT
SELECT a.対象月, a.作業区コード, b.作業区名 , a.前月残高, a.当月入金高, a.当月売上高_枚数, a.当月売上高_金額, a.当月売上高_消費税 , a.材料支給高_枚数, a.材料支給高_金額, a.材料支給高_消費税, a.当月請求高 , b.支払方法 AS 仕入先支払方法 , CASE WHEN COALESCE(c.支払方法,b.支払方法) = '1' THEN '現金' WHEN COALESCE(c.支払方法,b.支払方法) = '2' THEN '手形' WHEN COALESCE(c.支払方法,b.支払方法) = '3' THEN 'その他' ELSE '' END AS 支払方法 , c.金額 , COALESCE(c.バージョン番号, 0) AS バージョン番号 FROM T_検収 a LEFT OUTER JOIN M_作業区仕入先 b ON a.作業区コード = b.作業区コード LEFT OUTER JOIN T_支払 AS c ON c.対象月 = a.対象月 AND c.作業区コード = a.作業区コード
-- SQL_GETALL_WHERE_PAYMENT_MONTH
WHERE a.対象月 = ?
-- SQL_GETALL_ORDER
ORDER BY COALESCE(b.表示順,0), a.作業区コード


