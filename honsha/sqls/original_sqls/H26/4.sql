-- SQL_GET_SELECT
SELECT a.SeqNo ,a.仕入先コード ,COALESCE(b.作業区名,'') AS 仕入先名 ,a.取引分類 ,a.材質名 ,a.形状 ,a.重量 ,a.材料単位 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.支給先コード ,COALESCE(c.作業区名,'') AS 支給先名 ,a.支給金額 ,a.取引日 ,a.備考 ,a.バージョン番号 ,a.相殺方法 ,d.相殺日 ,d.重量 ,d.相殺金額 FROM T_仕入 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.仕入先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.支給先コード LEFT OUTER JOIN T_仕入相殺 AS d ON d.SeqNo = a.SeqNo WHERE a.SeqNo = CAST(? AS INT) ORDER BY d.相殺SeqNo


