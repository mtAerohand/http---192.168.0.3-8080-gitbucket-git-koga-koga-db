-- SQL_CHECK_EXISTS_REQUEST
SELECT CASE WHEN EXISTS (SELECT * FROM T_検査出荷依頼 WHERE 管理No = CAST(? as INT) AND 検査区分 = true AND 検査結果区分 IN ('1','2') AND 納入形態区分 IN ('1','2','4','11','12') ) THEN 1 /* 完了依頼有り */ ELSE CASE WHEN EXISTS (SELECT * FROM T_売上 WHERE 管理No = CAST(? as INT) AND 納入形態区分 IN ('1','2','4') ) THEN 1 /* 完了依頼有り */ ELSE 0 /* 完了依頼無し */ END END AS 判定


