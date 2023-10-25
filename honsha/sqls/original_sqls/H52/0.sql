-- SQL_REPORT_21_COUNT_TEMPLATE
SELECT CAST(COUNT(a.作業区コード) AS INT) %s %s %s
-- SQL_REPORT_21_COMMON
FROM T_発注 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS c ON c.工程コード = a.工程コード INNER JOIN T_受注 AS d ON d.管理No = a.管理No LEFT OUTER JOIN ( SELECT 伝票番号 ,SUM(受入数) AS 総受入数 FROM T_工程受入 GROUP BY 伝票番号 ) AS e ON e.伝票番号 = a.伝票番号 LEFT OUTER JOIN M_得意先 AS f ON f.得意先コード = d.得意先コード LEFT OUTER JOIN ( SELECT 管理No ,工程順序No ,回答日 ,希望納入数 FROM T_納期回答依頼 WHERE 回答日 IS NOT NULL ) AS g ON g.管理No = a.管理No AND g.工程順序No = a.工程順序No WHERE a.作業区コード = ? AND a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 伝票番号 = a.伝票番号 AND 受入形態区分 IN ('1','2'))
    -- SQL_REPORT_21_WHERE_TOKUISAKI(%s1)
    AND d.得意先コード = ?
    -- SQL_REPORT_21_WHERE_HINBANI(%s2)
    AND d.品番 &^ ?
    -- SQL_REPORT_21_ORDERBY(%s3)
    ORDER BY d.品番, a.納期, g.回答日


