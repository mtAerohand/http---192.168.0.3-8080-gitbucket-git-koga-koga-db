-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.品番) AS INT) FROM T_材料計算 AS a LEFT OUTER JOIN M_材質 AS b ON b.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS c ON c.材料形状コード = a.材料形状コード WHERE a.品番 &^ ?
-- SQL_GET_ALL
SELECT a.品番,a.設変番号,a.材質コード,COALESCE(b.材質名,'') AS 材質名,a.材料形状コード,COALESCE(c.材料形状名,'') AS 材料形状名,a.入力方法,a.正味材料費,a.材質ベース単価,a.材料費補正額,a.登録日 FROM T_材料計算 AS a LEFT OUTER JOIN M_材質 AS b ON b.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS c ON c.材料形状コード = a.材料形状コード WHERE a.品番 &^ ? ORDER BY a.品番, a.設変番号
-- SQL_GET
SELECT a.品番,a.設変番号,b.品名,a.登録日,a.材質コード,COALESCE(c.材質名,'') AS 材質名,COALESCE(c.比重,0) AS 比重,a.材料形状コード,a.材料径 ,a.材料長,a.製品長,a.残材長,a.入力方法,a.材質ベース単価,a.材料重量,a.材料単価,a.取数,a.材料費,a.製品材料重量,a.製品重量,a.くず回収率 ,a.くず単価,a.くず金額,a.正味材料費,a.材料費補正額,a.バージョン番号 FROM T_材料計算 AS a LEFT OUTER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード WHERE a.品番 = ? AND a.設変番号 = ?
-- SQL_SHAPE_DATA
SELECT 材料形状コード,材料形状名,増値設定,形状増値 FROM M_材料形状 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,材料形状コード
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_PLACES
SELECT CASE WHEN EXISTS(SELECT * FROM T_材料計算 WHERE 品番 = ? AND 設変番号 = ?) THEN 1 ELSE 0 END AS 判定
-- SQL_WIDTH
SELECT 突切幅 FROM M_突切幅 WHERE 材料径from <= CAST(? as NUMERIC) AND 材料径to >= CAST(? as NUMERIC)
-- SQL_PRICE
SELECT 材質コード,材質ベース単価 FROM M_材質ベース単価 WHERE 材質コード = ? AND CURRENT_DATE BETWEEN 適用開始日 AND 適用終了日

