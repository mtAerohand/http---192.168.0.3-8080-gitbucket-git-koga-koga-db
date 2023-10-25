-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.品番) AS INT) FROM M_部品 a
-- SQL_GET_ALL
SELECT a.品番, a.最新設変番号, a.品名, b.材質名, a.材質ベース単価, a.材料費, a.材料費補正額 FROM M_部品 a LEFT OUTER JOIN M_材質 b ON a.材質コード = b.材質コード
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE a.品番 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.品番
-- SQL_MULTIPLE
SELECT CAST(a.値 as INT) FROM M_パラメータ a WHERE a.Key1 = CAST(? AS INT) AND a.Key2 = ? AND a.Key3 = ?
-- SQL_GET
SELECT a.品番, a.最新設変番号, a.品名, a.材料費変動補正対象, a.材質コード, COALESCE(b.材質名,'') AS 材質名, a.材質ベース単価, a.材料費, a.材料費補正額, a.備考, a.バージョン番号, a.材料形状コード, a.材料径, a.製品長, a.得意先コード, COALESCE(c.得意先名,'') AS 得意先名 FROM M_部品 a LEFT OUTER JOIN M_材質 b ON a.材質コード = b.材質コード LEFT OUTER JOIN M_得意先 c ON a.得意先コード = c.得意先コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?
-- SQL_SHAPE_DATA
SELECT 材料形状コード,材料形状名,増値設定,形状増値 FROM M_材料形状 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,材料形状コード
-- SQL_EXPORT_M10
SELECT a.得意先コード, a.品番, a.品名, a.最新設変番号, a.材質コード, c.材質名, a.材料形状コード, b.材料形状名, a.材料径, a.製品長 FROM M_部品 a LEFT OUTER JOIN M_材料形状 b ON a.材料形状コード = b.材料形状コード LEFT OUTER JOIN M_材質 c ON a.材質コード = c.材質コード ORDER BY a.品番

