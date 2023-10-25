-- SQL_GETALL_COUNT
SELECT CAST(COUNT(SeqNo) AS INT) FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード
-- SQL_GETALL_WHERE
WHERE a.取引先区分 = ? AND a.売上日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_CODE
AND a.取引先コード = ?


