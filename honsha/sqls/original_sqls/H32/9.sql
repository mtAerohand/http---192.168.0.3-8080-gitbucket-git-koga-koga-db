-- SQL_GET_REQUEST2
SELECT a.管理No ,a.分納No ,a.工程順序No ,a.希望納入日 ,a.希望納入数 ,a.回答依頼作成 ,a.督促日 ,a.回答期限 ,a.回答日 ,a.依頼書種別 ,a.連絡手段 ,a.作業区コード ,a.作業区担当者コード ,COALESCE(b.担当者名,'') AS 作業区担当者名 ,COALESCE(b.メールアドレス,'') AS メールアドレス ,a.作業区担当者名 ,a.担当者コード AS 連絡者コード ,COALESCE(c.社員名,'') AS 連絡者名 ,a.コメント FROM T_納期回答依頼 AS a LEFT OUTER JOIN M_作業区担当者 AS b ON b.作業区コード = a.作業区コード AND b.担当者コード = a.作業区担当者コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード WHERE a.管理No = CAST(? as INT) ORDER BY a.分納No, a.工程順序No


