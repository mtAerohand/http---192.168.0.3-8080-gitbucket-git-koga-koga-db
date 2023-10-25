-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.SeqNo) AS INT) FROM T_受入返品 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_生産計画詳細 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No INNER JOIN T_発注 AS d ON d.管理No = a.管理No AND d.工程順序No = a.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = c.工程コード
-- SQL_GETALL_WHERE_HENPINBI
WHERE a.返品日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_HENPINSAKI
AND a.作業区コード = ?


