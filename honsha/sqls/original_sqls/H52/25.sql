-- SQL_REPORT_COUNT
SELECT CAST(COUNT(a.管理No) AS INT)
-- SQL_REPORT_12_CORE
FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN ( SELECT 管理No, MAX(回答日) AS 回答日 FROM T_納期回答 GROUP BY 管理No) AS c ON c.管理No = a.管理No LEFT OUTER JOIN ( SELECT x.管理No, x.納入日 FROM T_検査出荷依頼 AS x WHERE x.検査結果区分 <> '2' AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = x.管理No AND 分納No = x.分納No)) AS d ON d.管理No = a.管理No LEFT OUTER JOIN ( SELECT 管理No,SUM(依頼数) AS 完了数 FROM T_売上 GROUP BY 管理No) AS e ON e.管理No = a.管理No LEFT OUTER JOIN M_在庫 AS f ON f.品番 = a.品番 AND f.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(COALESCE(x.個数,0)) AS 実績入数 FROM T_売上詳細 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS g ON g.品番 = a.品番 AND g.設変番号 = a.設変番号 WHERE a.受注区分 IN ('2','3') AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 納入形態区分 IN ('1','2','4'))
    -- SQL_REPORT_NOUKI
    AND a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_TOKUISAKI
    AND a.得意先コード = ?
    -- SQL_REPORT_HINBAN
    AND a.品番 &^ ?
    -- SQL_REPORT_12_CHUUBAN_ALPHABET
    AND LEFT(a.受注番号,1) !~ '^[0-9]+$'
    -- SQL_REPORT_12_CHUUBAN_SUUJI
    AND LEFT(a.受注番号,1) ~ '^[0-9]+$'
    -- SQL_REPORT_12_ORDER_BY
    ORDER BY COALESCE(b.表示順,0), a.得意先コード, a.納期, a.品番, a.設変番号


