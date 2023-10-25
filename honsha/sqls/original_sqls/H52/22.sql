﻿-- SQL_REPORT_COUNT
SELECT CAST(COUNT(a.管理No) AS INT)
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

