-- SQL_REPORT_33_SELECT_TEMPLATE
SELECT x.請求元 ,CAST(COUNT(x.請求元) AS INT) AS 件数 ,SUM(x.金額) AS 売上金額 ,SUM(x.箱数) AS 箱数 ,SUM(x.袋数) AS 袋数 %s %s
-- SQL_REPORT_33_COMMON(%s1)
FROM ( SELECT b.請求元 ,a.金額 ,CASE WHEN a.梱包単位 = '1' THEN COALESCE(e.梱包数,0) ELSE 0 END AS 箱数 ,CASE WHEN a.梱包単位 = '1' THEN 0 ELSE COALESCE(e.梱包数,0) END AS 袋数 FROM T_売上 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No AND b.得意先コード = '1' AND b.受注区分 IN ('2','3') LEFT OUTER JOIN ( SELECT 管理No ,分納No ,SUM(梱包数) AS 梱包数 FROM T_売上詳細 GROUP BY 管理No, 分納No ) AS e ON e.管理No = a.管理No AND e.分納No = a.分納No WHERE a.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS x WHERE x.請求元 <> '' GROUP BY x.請求元
    -- SQL_REPORT_33_ORDERBY(%s2)
    ORDER BY x.請求元


