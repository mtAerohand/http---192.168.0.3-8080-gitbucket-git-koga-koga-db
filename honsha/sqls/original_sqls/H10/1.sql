-- SQL_GET_ALL
SELECT a.管理No ,a.得意先コード ,COALESCE(b.得意先略称,'') AS 得意先名 ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,a.受注日 ,a.納期 ,a.受注数 ,a.単価
-- SQL_GET_ALL_FROM_CLAUSE
FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND a.受注番号 &@ ? AND LENGTH(a.受注番号) = LENGTH(?)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.受注日 DESC, a.品番, a.受注番号

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    AND a.品番 &@ ? AND LENGTH(a.品番) = LENGTH(?)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.受注日 DESC, a.品番, a.受注番号

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    AND a.受注番号 &@ ? AND LENGTH(a.受注番号) = LENGTH(?)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.受注日 DESC, a.品番, a.受注番号

    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
    a.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.受注日 DESC, a.品番, a.受注番号

    -- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
    a.管理No = CAST(? as INT)


