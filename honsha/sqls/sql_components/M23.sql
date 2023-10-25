-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.材質コード) AS INT)
-- SQL_GET_ALL
SELECT a.材質コード,a.材質名,c.適用開始日,c.適用終了日,c.材質ベース単価
-- SQL_GET_ALL_FROM
FROM M_材質 AS a LEFT OUTER JOIN ( SELECT 材質コード,MAX(適用開始日) AS 適用開始日 FROM M_材質ベース単価 GROUP BY 材質コード ) AS b ON b.材質コード = a.材質コード LEFT OUTER JOIN M_材質ベース単価 AS c ON c.材質コード = b.材質コード AND c.適用開始日 = b.適用開始日 WHERE CURRENT_DATE BETWEEN a.有効開始日 AND a.有効終了日
-- SQL_GET_ALL_WHERE_CLAUSE_MATERIAL_NAME
AND a.材質名 LIKE ?
-- SQL_GET_ALL_WHERE_CLAUSE_BASE_PRICE
AND c.適用開始日 IS NOT NULL
-- SQL_GET_WHERE_CLAUSE_MATERIAL_CODE
AND a.材質コード = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.表示順, CAST(a.材質コード as INT)
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GET
SELECT a.材質コード,a.材質名,b.SeqNo,b.適用開始日,b.適用終了日,b.材質ベース単価,b.備考,b.バージョン番号 FROM M_材質 AS a LEFT OUTER JOIN M_材質ベース単価 AS b ON b.材質コード = a.材質コード WHERE a.材質コード = ? ORDER BY b.適用開始日

