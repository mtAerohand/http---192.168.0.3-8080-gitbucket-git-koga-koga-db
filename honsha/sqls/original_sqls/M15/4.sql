-- SQL_GET_GROUP
SELECT 社員コード ,社員名 FROM M_社員 WHERE 分類 = '1' AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,社員コード
