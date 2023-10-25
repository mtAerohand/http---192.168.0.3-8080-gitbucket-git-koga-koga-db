-- SQL_ADD_TANAOROSHI_EXISTS
SELECT CAST(COUNT(SeqNo) AS INT) AS 件数 FROM T_棚卸 WHERE 棚卸月 = ? AND 分類 = ? AND 作業区コード = ? AND (CASE WHEN 分類 = '1' THEN 品番 ELSE 材質名 END) = ? AND (CASE WHEN 分類 = '1' THEN 設変番号 ELSE 形状 END) = ?


