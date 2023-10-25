-- SQL_REPORT_63_ALL
SELECT a.棚卸月 ,a.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,a.仕掛品金額 + a.材料金額 AS 在庫金額 ,a.仕掛品金額 ,a.材料金額 FROM ( SELECT x.棚卸月 ,x.作業区コード ,SUM(x.仕掛品金額) AS 仕掛品金額 ,SUM(x.材料金額) AS 材料金額 FROM ( SELECT 棚卸月 ,作業区コード ,CASE 分類 WHEN '1' THEN 金額 ELSE 0 END AS 仕掛品金額 ,CASE 分類 WHEN '1' THEN 0 ELSE 金額 END AS 材料金額 FROM T_棚卸 ) AS x GROUP BY x.棚卸月, x.作業区コード ) AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.棚卸月 = ? ORDER BY COALESCE(b.表示順,0), a.作業区コード


