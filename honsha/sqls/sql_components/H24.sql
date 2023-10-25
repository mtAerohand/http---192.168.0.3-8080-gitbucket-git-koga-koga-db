-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GETALL_COUNT
SELECT CAST(COUNT(SeqNo) AS INT) FROM T_売上返品 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.得意先コード ,COALESCE(b.得意先略称,'') AS 得意先略称 ,a.品番 ,a.設変番号 ,a.数量 ,a.単価 ,a.金額 ,a.返品日 ,a.備考 FROM T_売上返品 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.返品日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_TOKUISAKI
AND a.得意先コード = ?
-- SQL_GETALL_WHERE_SEQNO
WHERE a.SeqNo = CAST(? AS INT)
-- SQL_GETALL_ORDERBY
ORDER BY a.返品日 DESC, a.品番, a.設変番号
-- SQL_GET_SELECT
SELECT a.SeqNo ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.数量 ,a.単価 ,a.金額 ,a.返品日 ,a.備考 ,a.バージョン番号 FROM T_売上返品 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.SeqNo = CAST(? AS INT)
-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM T_売上返品 WHERE 得意先コード = ? AND 品番 = ? AND 設変番号 = ? AND 返品日 = CAST(? as DATE) %s) THEN 1 ELSE 0 END AS 判定
-- SQL_EXISTS_WHERE_UPDATE
AND SeqNo <> CAST(? AS INT)
-- SQL_GET_REPORT
SELECT a.SeqNo ,a.得意先コード ,COALESCE(b.郵便番号1,'') AS 郵便番号1 ,COALESCE(b.郵便番号2,'') AS 郵便番号2 ,COALESCE(b.住所1,'') AS 住所1 ,COALESCE(b.住所2,'') AS 住所2 ,COALESCE(b.得意先名,'') AS 得意先名 ,a.返品日 ,a.品番 ,a.設変番号 ,c.品名 ,a.数量 ,a.単価 ,- a.金額 AS 金額 ,a.備考 FROM T_売上返品 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.SeqNo = ?

