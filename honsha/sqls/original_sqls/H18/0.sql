-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(A.管理No) AS INT)
-- SQL_GET_ALL_EDIT_FROM2
FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = b.得意先コード WHERE ((a.検査区分 = true AND a.検査結果区分 = '0') OR (a.検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)) )
-- 702
AND a.管理No = CAST(? AS INT)
-- 703
AND a.分納No = CAST(? AS INT)


