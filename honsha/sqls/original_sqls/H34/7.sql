-- H34/596
UPDATE T_納期回答依頼 SET 回答依頼作成 = false ,督促日 = CAST(? AS DATE) ,回答期限 = CAST(? AS TIMESTAMP) ,コメント = ? ,更新日時 = CAST(? AS TIMESTAMP) ,更新ユーザ名 = ? WHERE 管理No = ? AND 回答依頼作成 = true


