-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(社員コード) AS INT) FROM M_社員 AS a
-- SQL_GET_ALL
SELECT a.社員コード, a.社員名 ,CASE a.分類 WHEN '0' THEN '個人' ELSE 'グループ' END AS 分類 ,CASE a.所属 WHEN '1' THEN '本社' ELSE '工場' END AS 所属 ,CASE a.権限 WHEN '1' THEN '一般' WHEN '2' THEN '管理者' ELSE '' END AS 権限 ,CASE WHEN b.社員コード IS NOT NULL THEN b.社員名 ELSE '' END AS グループ ,a.表示順 ,a.有効開始日 ,a.有効終了日 FROM M_社員 AS a LEFT OUTER JOIN M_社員 AS b ON b.社員コード =a.グループ社員コード
-- SQL_GET_ALL_WHERE_CLAUSE_DEPARTMENT
WHERE a.所属 = ?
-- SQL_GET_ALL_WHERE_CLAUSE_EMPLOYEE
WHERE a.社員コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.表示順,a.社員コード
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GET_GROUP
SELECT 社員コード ,社員名 FROM M_社員 WHERE 分類 = '1' AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,社員コード

