-- SQL_GET_ALL
SELECT 得意先コード, 得意先名 ,CASE WHEN 得意先コード = '1' THEN '1' ELSE '0' END as 得意先区分 FROM M_得意先 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,得意先コード


