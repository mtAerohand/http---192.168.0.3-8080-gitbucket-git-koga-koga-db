-- SQL_CREATE_REPORT_HEADER_SELECT
SELECT b.郵便番号1, b.郵便番号2, b.住所1, b.住所2, b.作業区名 , a.前月残高, a.当月入金高, a.当月売上高_枚数, a.当月売上高_金額, a.当月売上高_消費税 , a.材料支給高_枚数, a.材料支給高_金額, a.材料支給高_消費税, a.当月請求高 FROM T_検収 a LEFT OUTER JOIN M_作業区仕入先 b ON a.作業区コード = b.作業区コード
-- SQL_CREATE_REPORT_HEADER_WHERE
WHERE a.対象月 = ? AND a.作業区コード = ?


