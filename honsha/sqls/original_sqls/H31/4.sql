-- SQL_GET_SELECT
SELECT a.対象月 ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,a.支払方法 ,a.金額 ,a.登録日 ,a.バージョン番号 FROM T_支払 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.対象月 = ? AND a.作業区コード = ?
