-- SQL_GETALL_SELECT
SELECT SeqNo ,CASE WHEN 分類 = '1' THEN '仕掛品' ELSE '材料' END AS 分類 ,品番 ,設変番号 ,数量 ,材質名 ,形状 ,重量 ,単価 ,評価率 ,金額 FROM T_棚卸
    -- SQL_GETALL_WHERE_TANAOROSHI
    WHERE 棚卸月 = ? AND 作業区コード = ?
    
    -- SQL_GETALL_WHERE_SEQNO
    WHERE SeqNo = CAST(? AS INT)
-- SQL_GETALL_ORDERBY
ORDER BY 分類, 品番, 設変番号, 材質名, 形状


