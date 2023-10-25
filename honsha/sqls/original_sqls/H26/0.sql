-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.仕入先コード ,CASE WHEN a.取引分類 = '1' THEN '材料' ELSE 'その他' END AS 取引分類 ,a.取引日 AS 仕入日 ,CASE WHEN a.取引分類 = '1' THEN a.材質名 ELSE a.品番 END AS 材質品番 ,CASE WHEN a.取引分類 = '1' THEN '' ELSE a.設変番号 END AS 設変番号 ,CASE WHEN a.取引分類 = '1' THEN a.形状 ELSE a.品名 END AS 形状品名 ,a.重量 ,a.数量 ,a.単価 ,a.金額 ,a.支給先コード ,COALESCE(b.作業区略称,'') AS 支給先名 FROM T_仕入 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.支給先コード
-- SQL_GETALL_WHERE
WHERE a.取引区分 = '1' AND a.仕入先コード = ? AND a.取引日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_ORDERBY
ORDER BY a.取引日 DESC, 材質品番, 設変番号, 形状品名


