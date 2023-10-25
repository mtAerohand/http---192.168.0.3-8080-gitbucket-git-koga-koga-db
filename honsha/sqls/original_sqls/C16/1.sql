-- SQL_GET_LOGIN
SELECT 社員コード,社員名,分類,メールアドレス,ユーザID ,パスワード,所属,権限,グループ社員コード,印刷グループ区分 FROM M_社員 WHERE ユーザID = ?
