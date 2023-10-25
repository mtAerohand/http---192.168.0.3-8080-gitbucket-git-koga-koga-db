-- SQL_BASE
SELECT a.管理No ,a.分納No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,CASE b.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS 受注区分 ,a.納入日 ,a.依頼日 ,a.出力日 ,c.社員コード ,COALESCE(c.社員名,'') AS 担当者名 ,a.バージョン番号 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.ユーザID = a.更新ユーザ名
    -- SQL_OUTPUT
    WHERE a.出力日 IS NULL AND a.依頼日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_REPUT
    WHERE a.出力日 IS NOT NULL AND a.依頼日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
        -- SQL_TARGET
        AND ((a.検査区分 = true AND a.検査結果区分 = '0') OR (a.検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)))

    -- SQL_ORDER
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
    -- SQL_NAME
    AND c.社員コード = ?
-- SQL_BY
ORDER BY a.依頼日 DESC, b.品番


