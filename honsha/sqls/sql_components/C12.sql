-- SQL_GET_ALL
SELECT 得意先コード,担当者コード,担当者名 FROM M_得意先担当者 WHERE 得意先コード = ? AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,担当者コード

