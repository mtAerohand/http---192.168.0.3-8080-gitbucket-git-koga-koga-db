-- SQL_CREATE_REPORT_DETAIL_SELECT
SELECT a.取引日, a.受注番号, a.枝番, a.品番材質, a.設変番号 , a.明細区分, a.数量重量, a.単価, a.金額, a.備考 FROM T_検収明細 a
-- SQL_CREATE_REPORT_DETAIL_WHERE
WHERE a.対象月 = ? AND a.作業区コード = ?
-- SQL_CREATE_REPORT_DETAIL_ORDER
ORDER BY a.取引日, a.品番材質
