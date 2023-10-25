-- SQL_REPORT_11_SELECT
SELECT a.管理No, a.得意先コード, COALESCE(b.得意先名,'') AS 得意先名, a.受注番号, a.枝番, a.品番, a.設変番号, a.品名, a.客先品番, a.受注日, a.納期, a.受注数, a.単価, CASE COALESCE(b.金額端数処理区分,'1') WHEN '1' THEN CAST(FLOOR(a.単価 * a.受注数) as BIGINT) WHEN '2' THEN CAST(CEIL(a.単価 * a.受注数) as BIGINT) ELSE CAST(ROUND((a.単価 * a.受注数),0) as BIGINT) END AS 受注金額,a.請求元 ,a.納入場所名 ,a.次工程名
-- SQL_REPORT_11_CORE
FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード WHERE a.受注区分 IN ('2','3')
    -- SQL_REPORT_TOKUISAKI
    AND a.得意先コード = ?
    -- SQL_REPORT_ZYUCHUUBI
    AND a.受注日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_NOUKI
    AND a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
    -- SQL_REPORT_HINBAN
    AND a.品番 &^ ?
    -- SQL_REPORT_11_ORDER_BY
    ORDER BY COALESCE(b.表示順,0), a.得意先コード, a.品番, a.受注日


