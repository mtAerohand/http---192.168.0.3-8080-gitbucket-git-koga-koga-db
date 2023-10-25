-- SQL_REPORT_25_SELECT_TEMPLATE
SELECT 作業区コード ,作業区 ,受注番号 ,枝番 ,品番 ,設変番号 ,発注日 ,納期 ,発注数 ,発注数 - 総受入数 AS 発注残数 ,回答数 ,CASE WHEN 回答日 IS NOT NULL THEN TO_CHAR(回答日, 'YYYY/FMMM/FMDD') ELSE '' END AS 回答日 ,得意先略称 ,CASE WHEN 受注有無 THEN '有' ELSE '無' END AS 受注引当 ,CASE WHEN 補正入数 <> 0 THEN 補正入数 ELSE 実績入数 END AS 入数/箱 ,CASE WHEN 補正入数 <> 0 THEN CEIL(回答数 / 補正入数) WHEN 実績入数 <> 0 THEN CEIL(回答数 / 実績入数) ELSE 0 END AS 箱数 %s %s %s %s
-- SQL_REPORT_25_COMMON(%s1)
FROM ( SELECT a.作業区コード ,COALESCE(f.作業区名, '') AS 作業区 ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,a.発注日 ,a.納期 ,a.発注数 ,COALESCE(( SELECT SUM(受入数) FROM T_工程受入 WHERE 伝票番号 = a.伝票番号 GROUP BY 伝票番号 ), 0) AS 総受入数 ,COALESCE(c.希望納入数, 0) AS 回答数 ,c.回答日 ,g.得意先略称 ,EXISTS( SELECT * FROM T_受注 AS ia WHERE ia.品番 = b.品番 AND 受注区分 IN ('2', '3') AND NOT EXISTS ( SELECT * FROM T_売上 AS ib WHERE ib.管理No = ia.管理No AND ib.納入形態区分 IN ('1', '2', '4') ) ) AS 受注有無 ,COALESCE(d.補正入数, 0) AS 補正入数 ,COALESCE(e.実績入数, 0) AS 実績入数 FROM ( SELECT * FROM T_発注 AS aa WHERE aa.最終工程区分 = true AND NOT EXISTS ( SELECT * FROM T_工程受入 AS ab WHERE aa.伝票番号 = ab.伝票番号 AND ab.受入形態区分 IN ('1', '2') ) ) AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN T_納期回答依頼 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No AND c.回答日 IS NOT NULL LEFT OUTER JOIN ( SELECT da.品番 ,da.補正入数 FROM M_在庫 AS da INNER JOIN ( SELECT 品番 ,MAX(設変番号) AS 設変番号 FROM M_在庫 GROUP BY 品番 ) AS db ON db.品番 = da.品番 AND db.設変番号 = da.設変番号 ) AS d ON d.品番 = b.品番 LEFT OUTER JOIN ( SELECT ec.品番 ,MAX(eb.個数) AS 実績入数 FROM T_売上 AS ea LEFT OUTER JOIN T_売上詳細 AS eb ON eb.管理No = ea.管理No INNER JOIN T_受注 AS ec ON ec.管理No = ea.管理No INNER JOIN ( SELECT edc.品番 ,MAX(edc.設変番号) AS 設変番号 FROM T_売上 AS eda LEFT OUTER JOIN T_売上詳細 AS edb ON edb.管理No = eda.管理No INNER JOIN T_受注 AS edc ON edc.管理No = eda.管理No GROUP BY edc.品番 ) AS ed ON ed.品番 = ec.品番 AND ed.設変番号 = ec.設変番号 GROUP BY ec.品番, ec.設変番号 ) AS e ON e.品番 = b.品番 LEFT OUTER JOIN M_作業区仕入先 AS f ON f.作業区コード = a.作業区コード LEFT OUTER JOIN M_得意先 AS g ON g.得意先コード = b.得意先コード) AS h
    -- SQL_REPORT_25_WHERE_SAGYOUKU(%s2)
    WHERE 作業区コード = ?
        -- 2367
        AND
        WHERE
    -- SQL_REPORT_25_WHERE_KAITOUBI(%s3)
    回答日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END AS DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END AS DATE)
    -- SQL_REPORT_25_ORDERBY(%s4)
    ORDER BY 納期, 回答日


