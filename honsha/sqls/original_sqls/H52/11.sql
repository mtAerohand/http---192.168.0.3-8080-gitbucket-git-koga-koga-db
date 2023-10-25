-- SQL_REPORT_44_COUNT_TEMPLATE
SELECT CAST(COUNT(a.作業区コード) AS INT) %s %s %s
-- SQL_REPORT_44_COMMON
FROM ( SELECT c.作業区コード ,c.年月 ,CAST(COUNT(c.作業区コード) as BIGINT) AS 件数 ,CAST(SUM(c.金額) as BIGINT) AS 金額 ,CAST(ROUND((SUM(c.金額)*0.1),0) as BIGINT) AS 消費税 FROM ( SELECT d.支給先コード AS 作業区コード ,CASE WHEN d.取引区分 = '1' AND d.相殺方法 = '2' THEN TO_CHAR(e.相殺日,'YYYY/MM') ELSE TO_CHAR(d.取引日 +interval '1 month' ,'YYYY/MM') END AS 年月 ,CASE WHEN d.取引区分 = '1' AND d.相殺方法 = '1' THEN d.支給金額 WHEN d.取引区分 = '1' AND d.相殺方法 = '2' THEN e.相殺金額 ELSE - d.支給金額 END AS 金額 FROM T_仕入 d LEFT OUTER JOIN T_仕入相殺 AS e ON e.SeqNo = d.SeqNo WHERE d.取引分類 = '1' AND CASE WHEN d.取引区分 = '1' AND d.相殺方法 = '2' THEN e.相殺日 ELSE d.取引日 + interval'1 month' END BETWEEN CAST(? as DATE) AND (CAST(? as DATE) + interval '1 month' ) - interval '1 day' UNION ALL SELECT f.取引先コード AS 作業区コード ,TO_CHAR(f.売上日,'YYYY/MM') AS 年月 ,f.金額 FROM T_売上任意 AS f WHERE f.取引先区分 = '2' AND f.売上日 BETWEEN CAST(? as DATE) AND (CAST(? as DATE) + interval '1 month' ) - interval '1 day' ) AS c GROUP BY c.作業区コード, c.年月 ) AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE b.検収書発行区分 = true
    -- SQL_REPORT_44_WHERE_SAGYOUKU
    AND a.作業区コード = ?
    -- SQL_REPORT_44_ORDERBY
    ORDER BY a.作業区コード, a.年月


