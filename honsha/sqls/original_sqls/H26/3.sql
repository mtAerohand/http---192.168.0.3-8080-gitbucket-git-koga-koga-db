-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.SeqNo) AS INT) FROM T_仕入 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.支給先コード WHERE a.取引区分 = '1' AND a.仕入先コード = ? AND a.取引日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)


