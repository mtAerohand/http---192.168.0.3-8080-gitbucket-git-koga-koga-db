-- SQL_REPORT_24_SELECT_TEMPLATE
SELECT a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(c.工程略称,'') AS 工程名 ,d.受注番号 ,d.枝番 ,d.品番 ,d.設変番号 ,d.品名 ,a.発注日 ,a.納期 ,CASE WHEN f.回答日 IS NOT NULL THEN CAST(DATE_PART('YEAR',f.回答日) as VARCHAR) || '/' || CAST(DATE_PART('MONTH',f.回答日) as VARCHAR) || '/' || CAST(DATE_PART('DAY',f.回答日) as VARCHAR) ELSE '' END AS 回答日 ,COALESCE(f.希望納入数,0) AS 回答数 ,a.発注数 ,CASE COALESCE(h.受入形態区分,'') WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,COALESCE(g.受入数,0) AS 受入数 ,a.単価 ,CAST(TRUNC(a.単価 * a.発注数,0) as BIGINT) AS 発注金額 ,d.単価 AS 売値 ,CASE COALESCE(k.金額端数処理区分,'1') WHEN '1' THEN CAST(FLOOR(d.単価 * d.受注数) as BIGINT) WHEN '2' THEN CAST(CEIL(d.単価 * d.受注数) as BIGINT) ELSE CAST(ROUND((d.単価 * d.受注数),0) as BIGINT) END AS 売値金額 ,COALESCE(i.作業区コード,'') AS 次工程コード ,CASE WHEN i.作業区コード IS NULL THEN '古河（本社）' ELSE COALESCE(j.作業区名,'') END AS 次工程名 %s %s %s %s
-- SQL_REPORT_24_COMMON(%s1)
FROM T_発注 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS c ON c.工程コード = a.工程コード INNER JOIN T_受注 AS d ON d.管理No = a.管理No LEFT OUTER JOIN M_得意先 AS k ON k.得意先コード = d.得意先コード LEFT OUTER JOIN ( SELECT 管理No ,工程順序No ,MIN(分納No) AS 分納No FROM T_納期回答依頼 WHERE 回答日 IS NOT NULL GROUP BY 管理No, 工程順序No ) AS e ON e.管理No = a.管理No AND e.工程順序No = a.工程順序No LEFT OUTER JOIN T_納期回答依頼 AS f ON f.管理No = e.管理No AND f.工程順序No = e.工程順序No AND f.分納No = e.分納No LEFT OUTER JOIN ( SELECT 伝票番号 ,MAX(分納No) AS 分納No ,SUM(受入数) AS 受入数 FROM T_工程受入 GROUP BY 伝票番号 ) AS g ON g.伝票番号 = a.伝票番号 LEFT OUTER JOIN T_工程受入 AS h ON h.伝票番号 = g.伝票番号 AND h.分納No = g.分納No LEFT OUTER JOIN T_生産計画詳細 AS i ON i.管理No = a.管理No AND i.工程順序No = (a.工程順序No + 1) LEFT OUTER JOIN M_作業区仕入先 AS j ON j.作業区コード = i.作業区コード WHERE a.発注日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_24_WHERE_SAGYOUKU(%s2)
    AND a.作業区コード = ?
    -- SQL_REPORT_24_WHERE_HINBANI(%s3)
    AND d.品番 &^ ?
    -- SQL_REPORT_24_ORDERBY(%s4)
    ORDER BY a.作業区コード, d.品番, a.発注日, a.納期


