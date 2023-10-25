-- SQL_GET_ALL
SELECT * FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT DISTINCT a.管理No ,a.工程順序No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,a.作業区コード ,COALESCE(c.作業区略称,'') AS 作業区名 ,CASE a.連絡手段 WHEN '1' THEN COALESCE(d.担当者名,'') ELSE a.作業区担当者名 END AS 作業区担当者名 ,a.担当者コード ,COALESCE(e.社員名,'') AS 連絡者名 ,a.督促日 ,CASE WHEN a.回答期限 < CURRENT_TIMESTAMP THEN 1 ELSE 0 END AS カラー区分 ,a.回答期限 FROM T_納期回答依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_作業区担当者 AS d ON d.作業区コード = a.作業区コード AND d.担当者コード = a.作業区担当者コード LEFT OUTER JOIN M_社員 AS e ON e.社員コード = a.担当者コード WHERE a.回答日 IS NULL )as x WHERE x.督促日 IS NOT NULL AND x.督促日 BETWEEN CAST(CASE WHEN ? =''THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? =''THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = x.管理No AND 工程順序No = x.工程順序No AND 受入形態区分 IN ('1','2'))

    -- SQL_GET_WHERE_CLAUSE_WORK_DIVISION_NO
    AND x.作業区コード = ?
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY x.回答期限, x.品番

    -- SQL_GET_WHERE_CLAUSE_PERSON_NO
    AND x.担当者コード = ?
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY x.回答期限, x.品番

    -- SQL_GET_WHERE_CLAUSE_WORK_DIVISION_NO
    AND x.作業区コード = ?
    -- SQL_GET_WHERE_CLAUSE_LIMIT_DATE
    AND x.回答期限 < CURRENT_TIMESTAMP
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY x.回答期限, x.品番

    -- SQL_GET_WHERE_CLAUSE_PERSON_NO
    AND x.担当者コード = ?
    -- SQL_GET_WHERE_CLAUSE_LIMIT_DATE
    AND x.回答期限 < CURRENT_TIMESTAMP
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY x.回答期限, x.品番
