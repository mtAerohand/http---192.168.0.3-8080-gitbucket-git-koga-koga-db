-- SQL_GET_ALL_VOID_EFFECTIVE_DATE
SELECT 得意先コード, 得意先名, 得意先略称, 郵便番号1, 郵便番号2, 住所1, 住所2, 締日区分, 締日 ,CASE WHEN 得意先コード = '1' THEN '1' ELSE '0' END as 得意先区分 FROM M_得意先 WHERE 得意先コード = ?


