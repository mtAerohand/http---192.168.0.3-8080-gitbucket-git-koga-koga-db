-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.対象月) AS INT) FROM T_支払 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.対象月 = ?


