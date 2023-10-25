-- SQL_GET_ALL_NEW_SHUKKA_SELECT
SELECT A.管理No ,COALESCE(C.分納No,0) + 1 AS 分納No ,A.受注番号 ,A.枝番 ,A.品番 ,A.設変番号 ,A.納期 ,A.受注数 ,C.依頼日 ,C.依頼数 ,A.担当者コード ,COALESCE(D.社員名,'') AS 担当者名 ,CASE A.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS 受注区分 ,A.得意先コード ,COALESCE(E.得意先略称,'') AS 得意先名
-- SQL_GET_ALL_NEW_SHUKKA_FROM
FROM ( SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.納期 ,a.受注数 ,a.担当者コード ,a.受注区分 ,a.得意先コード FROM T_受注 AS a WHERE a.受注区分 IN ('2','3') ) AS A LEFT OUTER JOIN ( SELECT 管理No ,MAX(分納No) AS 分納No FROM T_検査出荷依頼 GROUP BY 管理No ) AS B ON B.管理No = A.管理No LEFT OUTER JOIN T_検査出荷依頼 AS C ON C.管理No = B.管理No AND C.分納No = B.分納No LEFT OUTER JOIN M_社員 AS D ON D.社員コード = A.担当者コード LEFT OUTER JOIN M_得意先 AS E ON E.得意先コード = A.得意先コード WHERE NOT EXISTS ( SELECT * FROM T_検査出荷依頼 AS x WHERE x.管理No = A.管理No AND (x.納入形態区分 IN ('1','2','4','11','12') OR (検査区分 = true AND 検査結果区分 = '0') OR (出荷区分 <> '0' AND 検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = x.管理No AND 分納No = x.分納No)))) AND EXISTS ( SELECT * FROM M_在庫 WHERE 品番 = A.品番 AND 設変番号 = A.設変番号 AND 在庫数 > 0)
    -- orderNoWhere
    AND A.受注番号 &@ ? AND LENGTH(A.受注番号) = LENGTH(?)
    -- employeeWhere
    AND A.担当者コード = ?
    -- SQL_GET_ALL_NEW_SHUKKA_ORDER
    ORDER BY A.品番, A.設変番号, A.納期

    -- orderNoWhere
    AND A.受注番号 &@ ? AND LENGTH(A.受注番号) = LENGTH(?)
    -- SQL_GET_ALL_NEW_SHUKKA_ORDER
    ORDER BY A.品番, A.設変番号, A.納期

    -- employeeWhere
    AND A.担当者コード = ?
    -- SQL_GET_ALL_NEW_SHUKKA_ORDER
    ORDER BY A.品番, A.設変番号, A.納期

    -- SQL_GET_ALL_NEW_SHUKKA_ORDER
    ORDER BY A.品番, A.設変番号, A.納期


