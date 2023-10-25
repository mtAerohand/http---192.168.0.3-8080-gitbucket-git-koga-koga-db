-- SQL_GET_ALL
SELECT 社員コード,社員名,メールアドレス FROM M_社員 WHERE 所属 = '1' AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,社員コード


