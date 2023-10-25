-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.取引先コード ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.得意先略称,'') ELSE COALESCE(c.作業区略称,'') END AS 取引先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.売上日 FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード
-- SQL_GETALL_WHERE
WHERE a.取引先区分 = ? AND a.売上日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_CODE
AND a.取引先コード = ?
-- SQL_GETALL_ORDERBY
ORDER BY a.売上日 DESC, a.品番, a.設変番号


