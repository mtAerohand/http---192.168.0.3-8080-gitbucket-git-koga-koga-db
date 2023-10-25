-- SQL_GET_ALL
SELECT 社員コード,社員名,メールアドレス FROM M_社員 WHERE 所属 = '1' AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,社員コード
-- SQL_GET_LOGIN
SELECT 社員コード,社員名,分類,メールアドレス,ユーザID ,パスワード,所属,権限,グループ社員コード,印刷グループ区分 FROM M_社員 WHERE ユーザID = ?

