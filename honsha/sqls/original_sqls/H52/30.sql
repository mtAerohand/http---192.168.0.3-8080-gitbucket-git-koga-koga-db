-- SQL_REPORT_14_SELECT
SELECT COALESCE(y.得意先名,'') AS 得意先名,x.*
-- SQL_REPORT_14_CORE1
FROM (SELECT a.得意先コード,a.受注番号,a.枝番,a.品番,a.設変番号,a.品名,a.受注日,a.受注数,a.単価 AS 受注単価,b.加工費 + b.材料費 AS 原価,CASE WHEN a.単価 <> 0 THEN CAST(TRUNC((b.加工費 + b.材料費) / a.単価 * 100,0) as BIGINT) ELSE 0 END AS 原価率,CAST(TRUNC(a.単価 * a.受注数,0) as BIGINT) AS 受注金額 FROM T_受注 AS a INNER JOIN ( SELECT 管理No ,SUM(加工費) AS 加工費 ,SUM(材料費) AS 材料費 FROM T_生産計画詳細 GROUP BY 管理No ) AS b ON b.管理No = a.管理No WHERE a.受注区分 <> '2'
    -- SQL_REPORT_TOKUISAKI
    AND a.得意先コード = ?
    -- SQL_REPORT_ZYUCHUUBI
    AND a.受注日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_HINBAN
    AND a.品番 &^ ?
-- SQL_REPORT_14_CORE2
) AS x LEFT OUTER JOIN M_得意先 AS y ON y.得意先コード = x.得意先コード
    -- SQL_REPORT_GENKARITSU
    WHERE x.原価率 BETWEEN CAST(CASE WHEN ? = '' THEN '0' ELSE ? END as INT) AND CAST(CASE WHEN ? = '' THEN '100' ELSE ? END as INT)
    -- SQL_REPORT_14_ORDER_BY
    ORDER BY COALESCE(y.表示順,0), x.得意先コード, x.品番, x.受注日


