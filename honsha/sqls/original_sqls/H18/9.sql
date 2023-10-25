-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(A.管理No) AS INT)
-- SQL_GET_ALL_NEW_SHUKKA_FROM
FROM ( SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.納期 ,a.受注数 ,a.担当者コード ,a.受注区分 ,a.得意先コード FROM T_受注 AS a WHERE a.受注区分 IN ('2','3') ) AS A LEFT OUTER JOIN ( SELECT 管理No ,MAX(分納No) AS 分納No FROM T_検査出荷依頼 GROUP BY 管理No ) AS B ON B.管理No = A.管理No LEFT OUTER JOIN T_検査出荷依頼 AS C ON C.管理No = B.管理No AND C.分納No = B.分納No LEFT OUTER JOIN M_社員 AS D ON D.社員コード = A.担当者コード LEFT OUTER JOIN M_得意先 AS E ON E.得意先コード = A.得意先コード WHERE NOT EXISTS ( SELECT * FROM T_検査出荷依頼 AS x WHERE x.管理No = A.管理No AND (x.納入形態区分 IN ('1','2','4','11','12') OR (検査区分 = true AND 検査結果区分 = '0') OR (出荷区分 <> '0' AND 検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = x.管理No AND 分納No = x.分納No)))) AND EXISTS ( SELECT * FROM M_在庫 WHERE 品番 = A.品番 AND 設変番号 = A.設変番号 AND 在庫数 > 0)
    -- 723
    AND A.受注番号 &@ ? AND LENGTH(A.受注番号) = LENGTH(?)
    -- 725
    AND A.担当者コード = ?

    -- 723
    AND A.受注番号 &@ ? AND LENGTH(A.受注番号) = LENGTH(?)

    -- 725
    AND A.担当者コード = ?
