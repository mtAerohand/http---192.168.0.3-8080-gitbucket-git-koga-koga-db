-- SQL_SHAPE_DATA
SELECT 材料形状コード,材料形状名,増値設定,形状増値 FROM M_材料形状 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,材料形状コード


