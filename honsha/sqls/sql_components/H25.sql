-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GETALL_COUNT
SELECT CAST(COUNT(SeqNo) AS INT) FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード
-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.取引先コード ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.得意先略称,'') ELSE COALESCE(c.作業区略称,'') END AS 取引先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.売上日 FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード
-- SQL_GETALL_WHERE
WHERE a.取引先区分 = ? AND a.売上日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_CODE
AND a.取引先コード = ?
-- SQL_GETALL_WHERE_SEQNO
WHERE a.SeqNo = CAST(? as INT)
-- SQL_GETALL_ORDERBY
ORDER BY a.売上日 DESC, a.品番, a.設変番号
-- SQL_GET_SELECT
SELECT a.SeqNo ,a.取引先区分 ,a.取引先コード ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.得意先名,'') ELSE COALESCE(c.作業区名,'') END AS 取引先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.売上日 ,a.備考 ,a.バージョン番号 FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード WHERE a.SeqNo = CAST(? as INT)
-- SQL_NOUHINSYO
SELECT a.SeqNo ,a.取引先コード ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.郵便番号1,'') ELSE COALESCE(c.郵便番号1,'') END AS 郵便番号1 ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.郵便番号2,'') ELSE COALESCE(c.郵便番号2,'') END AS 郵便番号2 ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.住所1,'') ELSE COALESCE(c.住所1,'') END AS 住所1 ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.住所2,'') ELSE COALESCE(c.住所2,'') END AS 住所2 ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.得意先名,'') ELSE COALESCE(c.作業区名,'') END AS 取引先名 ,a.売上日 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.備考 FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード WHERE a.SeqNo = ?
-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM T_売上任意 WHERE 取引先区分 = ? AND 取引先コード = ? AND 品番 = ? AND 設変番号 = ? AND 売上日 = ? %s ) THEN 1 ELSE 0 END AS 判定
-- SQL_EXISTS_WHERE_UPDATE
AND SeqNo <> ?

