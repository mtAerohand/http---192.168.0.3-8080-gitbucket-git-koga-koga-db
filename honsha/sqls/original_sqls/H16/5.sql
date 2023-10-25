-- SQL_BEFORE_TIME_FOR_DELIVERY_ORDER
SELECT CASE WHEN EXISTS( SELECT * FROM ( SELECT a.作業区コード ,a.納期 ,b.品番 ,b.設変番号 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.伝票番号 = CAST(? AS INT) ) AS x INNER JOIN ( SELECT a.作業区コード ,a.納期 ,b.品番 ,b.設変番号 FROM T_受注 AS b INNER JOIN T_発注 AS a ON a.管理No = b.管理No WHERE NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No AND 受入形態区分 IN ('1','2')) ) AS y ON y.品番 = x.品番 AND y.設変番号 = x.設変番号 AND y.作業区コード = x.作業区コード AND y.納期 < x.納期 ) THEN 1 ELSE 0 END AS 判定


