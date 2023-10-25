-- SQL_GET_ALL
SELECT 得意先コード ,次工程コード ,次工程名 FROM M_次工程 WHERE 得意先コード = ? AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,次工程コード


