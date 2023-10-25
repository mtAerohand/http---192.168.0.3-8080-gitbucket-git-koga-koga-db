-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.作業区コード ,COALESCE(e.作業区略称,'') AS 作業区名 ,a.返品日 ,a.管理No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,a.工程順序No ,c.工程コード ,COALESCE(f.工程略称,'') AS 工程名 ,d.伝票番号 ,a.数量 ,a.返品書発行日 FROM T_受入返品 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_生産計画詳細 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No INNER JOIN T_発注 AS d ON d.管理No = a.管理No AND d.工程順序No = a.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = c.工程コード
-- SQL_GETALL_WHERE_SEQNO
WHERE a.SeqNo = CAST(? AS INT)


