-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GETALL_SELECT_COUNT
SELECT CAST(COUNT(SeqNo) AS INT) FROM T_棚卸
-- SQL_GETALL_SELECT
SELECT SeqNo ,CASE WHEN 分類 = '1' THEN '仕掛品' ELSE '材料' END AS 分類 ,品番 ,設変番号 ,数量 ,材質名 ,形状 ,重量 ,単価 ,評価率 ,金額 FROM T_棚卸
-- SQL_GETALL_WHERE_TANAOROSHI
WHERE 棚卸月 = ? AND 作業区コード = ?
-- SQL_GETALL_WHERE_SEQNO
WHERE SeqNo = CAST(? AS INT)
-- SQL_GETALL_ORDERBY
ORDER BY 分類, 品番, 設変番号, 材質名, 形状
-- SQL_GETHISTORYLIST_SELECT
SELECT a.棚卸月 FROM ( SELECT DISTINCT 棚卸月 FROM T_棚卸 ) AS a ORDER BY a.棚卸月 DESC LIMIT 3
-- SQL_GET_SELECT
SELECT a.SeqNo ,LEFT(a.棚卸月,4) AS 棚卸年 ,RIGHT(a.棚卸月,2) AS 棚卸月 ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,a.分類 ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.数量 ,a.評価率 ,a.評価単価 ,a.材質名 ,a.形状 ,a.重量 ,a.単価 ,a.金額 ,a.バージョン番号 FROM T_棚卸 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.SeqNo = CAST(? AS INT)
-- SQL_GETORDER_SELECT
SELECT b.品番 ,b.設変番号 ,b.単価 ,b.受注日 ,b.受注数 FROM (SELECT 品番, 設変番号, MAX(受注日) AS 受注日 FROM T_受注 WHERE 品番 = ? AND 設変番号 = ? GROUP BY 品番, 設変番号) AS a INNER JOIN T_受注 AS b ON b.品番 = a.品番 AND b.設変番号 = a.設変番号 AND b.受注日 = a.受注日 LIMIT 1
-- SQL_GETPURCHASE_SELECT
SELECT b.材質名 ,b.形状 ,b.単価 ,b.取引日 ,b.重量 FROM (SELECT 材質名, 形状, MAX(取引日) AS 取引日 FROM T_仕入 WHERE 取引区分 = '1' AND 取引分類 = '1' AND 材質名 = ? AND 形状 = ? GROUP BY 材質名, 形状) AS a INNER JOIN T_仕入 AS b ON b.材質名 = a.材質名 AND b.形状 = a.形状 AND b.取引日 = a.取引日 LIMIT 1
-- SQL_ADD_TANAOROSHI_EXISTS
SELECT CAST(COUNT(SeqNo) AS INT) AS 件数 FROM T_棚卸 WHERE 棚卸月 = ? AND 分類 = ? AND 作業区コード = ? AND (CASE WHEN 分類 = '1' THEN 品番 ELSE 材質名 END) = ? AND (CASE WHEN 分類 = '1' THEN 設変番号 ELSE 形状 END) = ?
-- SQL_UPDATE_TANAOROSHI_EXISTS_WHERE
AND SeqNo <> CAST(? AS INT)

