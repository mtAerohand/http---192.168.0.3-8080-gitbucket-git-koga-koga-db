-- SQL_GET_SELECT
SELECT a.SeqNo ,LEFT(a.棚卸月,4) AS 棚卸年 ,RIGHT(a.棚卸月,2) AS 棚卸月 ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,a.分類 ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.数量 ,a.評価率 ,a.評価単価 ,a.材質名 ,a.形状 ,a.重量 ,a.単価 ,a.金額 ,a.バージョン番号 FROM T_棚卸 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.SeqNo = CAST(? AS INT)


