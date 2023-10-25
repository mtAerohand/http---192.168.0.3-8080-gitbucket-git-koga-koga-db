-- SQL_REPORT_51_COUNT_TEMPLATE
SELECT CAST(COUNT(a.得意先コード) AS INT) %s %s %s
-- SQL_REPORT_51_COMMON(%s1)
FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN T_図面詳細 AS d ON d.SeqNo = a.SeqNo LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード WHERE a.得意先コード = ? AND a.通知日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_51_WHERE_HINBAN(%s2)
    AND a.品番 &^ ?
    -- SQL_REPORT_51_ORDERBY(%s3)
    ORDER BY a.品番, a.設変番号, a.通知日, COALESCE(d.工程順序No,0)


