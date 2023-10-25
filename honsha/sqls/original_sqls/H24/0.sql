-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.得意先コード ,COALESCE(b.得意先略称,'') AS 得意先略称 ,a.品番 ,a.設変番号 ,a.数量 ,a.単価 ,a.金額 ,a.返品日 ,a.備考 FROM T_売上返品 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.返品日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_ORDERBY
ORDER BY a.返品日 DESC, a.品番, a.設変番号


