-- SQL_GETALL_SELECT
SELECT a.対象月 ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,CASE WHEN a.支払方法 = '1' THEN a.金額 ELSE 0 END AS 現金支払額 ,CASE WHEN a.支払方法 = '2' THEN a.金額 ELSE 0 END AS 手形支払額 ,CASE WHEN a.支払方法 = '3' THEN a.金額 ELSE 0 END AS その他支払額 ,a.登録日 FROM T_支払 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.対象月 = ?
-- SQL_GETALL_WHERE_CODE
AND a.作業区コード = ?


