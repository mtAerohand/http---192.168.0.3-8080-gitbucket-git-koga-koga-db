-- SQL_GET_ALL
SELECT 工号, 有効開始日, 有効終了日, 図番, 設変番号, 定量数, 納期, 単価, 四半期予定数, 年度予定数 FROM M_納入メモ
    -- SQL_GET_ALL_WHERE_KOUGOU_CLAUSE
    WHERE 工号 = ?
    
    -- SQL_GET_ALL_WHERE_ZUBAN_CLAUSE
    WHERE 図番 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 工号
