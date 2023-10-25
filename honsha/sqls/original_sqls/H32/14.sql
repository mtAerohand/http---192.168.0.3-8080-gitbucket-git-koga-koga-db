-- SQL_GET_MEMO
SELECT 工号 ,四半期予定数 ,年度予定数 ,納期 FROM M_納入メモ WHERE 工号 = ? AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日


