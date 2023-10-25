-- SQL_REPORT_63_SHOUSAI
SELECT a.棚卸月 ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,CASE a.分類 WHEN '1' THEN '仕掛品' ELSE '材料' END AS 分類 ,CASE a.分類 WHEN '1' THEN a.品番 ELSE a.材質名 END AS 品番材質 ,CASE a.分類 WHEN '1' THEN a.設変番号 ELSE '' END AS 設変番号 ,CASE a.分類 WHEN '1' THEN COALESCE(c.品名,'') ELSE a.形状 END AS 品名形状 ,CASE a.分類 WHEN '1' THEN a.数量 ELSE a.重量 END AS 数量 ,a.単価 ,CASE a.分類 WHEN '1' THEN a.評価率 ELSE NULL END AS 評価率 ,CASE a.分類 WHEN '1' THEN a.評価単価 ELSE NULL END AS 評価単価 ,a.金額 FROM T_棚卸 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.棚卸月 = ? %s %s
    -- SQL_REPORT_63_SHOUSAI_SHIIRESAKI(%s1)
    AND a.作業区コード = ?
-- SQL_REPORT_63_SHOUSAI_SAGYOUKU_ORDER_BY(%s2)
ORDER BY COALESCE(b.表示順,0), a.作業区コード, a.分類, 品番材質, 設変番号, 品名形状


