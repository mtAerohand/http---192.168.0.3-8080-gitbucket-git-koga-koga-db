-- SQL_GET_ALL
SELECT a.材質コード,a.材質名,c.適用開始日,c.適用終了日,c.材質ベース単価
-- SQL_GET_ALL_FROM
FROM M_材質 AS a LEFT OUTER JOIN ( SELECT 材質コード,MAX(適用開始日) AS 適用開始日 FROM M_材質ベース単価 GROUP BY 材質コード ) AS b ON b.材質コード = a.材質コード LEFT OUTER JOIN M_材質ベース単価 AS c ON c.材質コード = b.材質コード AND c.適用開始日 = b.適用開始日 WHERE CURRENT_DATE BETWEEN a.有効開始日 AND a.有効終了日
-- SQL_GET_WHERE_CLAUSE_MATERIAL_CODE
AND a.材質コード = ?
