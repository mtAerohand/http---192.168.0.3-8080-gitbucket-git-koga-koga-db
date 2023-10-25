-- SQL_REPORT_51_SELECT_TEMPLATE
SELECT a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.通知日 ,CASE a.図面種類 WHEN '1' THEN '図面配布' ELSE '設変通知' END AS 図面種類 ,CASE a.図面種類 WHEN '1' THEN '' ELSE a.新設変番号 END AS 新設変番号 ,CASE a.作業指示区分 WHEN '1' THEN '工程変更' WHEN '2' THEN '製造中止' ELSE '' END AS 作業指示 ,CASE a.仕掛品対処区分 WHEN '1' THEN '使用可' WHEN '2' THEN '修正' WHEN '3' THEN '使用不可' ELSE '' END AS 仕掛品対処 ,COALESCE(d.作業区コード,'') AS 作業区コード ,COALESCE(e.作業区名,'') AS 作業区名 ,a.発行日 ,d.返却日 %s %s %s
-- SQL_REPORT_51_COMMON(%s1)
FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN T_図面詳細 AS d ON d.SeqNo = a.SeqNo LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード WHERE a.得意先コード = ? AND a.通知日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_51_WHERE_HINBAN(%s2)
    AND a.品番 &^ ?
    -- SQL_REPORT_51_ORDERBY(%s3)
    ORDER BY a.品番, a.設変番号, a.通知日, COALESCE(d.工程順序No,0)


