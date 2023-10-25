-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(x.管理No) AS INT) FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.受注日 ,a.納期 ,b.登録日 AS 計画作成日 ,CASE WHEN EXISTS (SELECT * FROM T_発注 WHERE 管理No = a.管理No) THEN '済' ELSE '' END AS 発注状況 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,a.得意先コード ,COALESCE(d.得意先略称,'') AS 得意先名 FROM T_受注 AS a LEFT OUTER JOIN T_生産計画 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = a.得意先コード WHERE a.受注区分 <> '2' ) AS x
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    x.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND x.受注番号 &@ ? AND LENGTH(x.受注番号) = LENGTH(?)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.受注日 DESC, 品番
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.受注日 DESC, 品番

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    x.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    AND x.品番 &@ ? AND LENGTH(x.品番) = LENGTH(?)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.受注日 DESC, 品番
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.受注日 DESC, 品番

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    x.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.受注日 DESC, 品番
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.受注日 DESC, 品番

    -- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
    x.管理No = CAST(? as INT)

        -- SQL_GET_ALL_WHERE_CLAUSE_TARGET
        AND x.計画作成日 IS NULL

            -- SQL_GET_ALL_ORDER_BY_CLAUSE
            ORDER BY x.受注日 DESC, 品番
    
        -- SQL_GET_ALL_ORDER_BY_CLAUSE
        ORDER BY x.受注日 DESC, 品番
