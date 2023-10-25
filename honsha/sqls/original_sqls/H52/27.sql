-- SQL_REPORT_13_COUNT
SELECT CAST(COUNT(a.得意先コード) AS INT)
-- SQL_REPORT_13_CORE1
FROM ( SELECT x.得意先コード ,CAST(COUNT(x.得意先コード) AS INT) AS 受注残件数 ,CAST(SUM(x.受注残金額) AS BIGINT) AS 受注残金額 FROM ( SELECT a.得意先コード ,CASE WHEN a.受注数 - COALESCE(c.完了数,0) > 0 THEN CASE b.金額端数処理区分 WHEN '1' THEN CAST(FLOOR(a.単価 * (a.受注数 - COALESCE(c.完了数,0))) as BIGINT) WHEN '2' THEN CAST(CEIL(a.単価 * (a.受注数 - COALESCE(c.完了数,0))) as BIGINT) ELSE CAST(ROUND((a.単価 * (a.受注数 - COALESCE(c.完了数,0))),0) as BIGINT) END ELSE 0 END AS 受注残金額 FROM T_受注 AS a INNER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN ( SELECT 管理No ,SUM(依頼数) AS 完了数 FROM T_売上 GROUP BY 管理No ) AS c ON c.管理No = a.管理No WHERE a.受注区分 IN ('2','3') AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 納入形態区分 IN ('1','2','4'))
    -- SQL_REPORT_NOUKI
    AND a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
-- SQL_REPORT_13_CORE2
) AS x GROUP BY x.得意先コード ) AS A INNER JOIN M_得意先 AS B ON B.得意先コード = A.得意先コード
    -- SQL_REPORT_13_ORDER_BY
    ORDER BY A.受注残金額 DESC, B.表示順, A.得意先コード


