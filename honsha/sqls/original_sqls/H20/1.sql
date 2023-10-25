-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.管理No) AS INT) FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.検査区分 = true AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)
    -- SQL_WHERE_DIVID
    AND a.管理No = CAST(? AS INT) AND a.分納No = CAST(? AS INT)

    -- SQL_WHERE_UNCHECK
    AND a.検査結果区分 = '0'

    -- SQL_WHERE_UNCHECK
    AND a.検査結果区分 = '0'
    -- SQL_WHERE_ORDER
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)

    -- SQL_WHERE_CHECK
    AND a.検査結果区分 <> '0' AND a.結果登録日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_WHERE_ORDER
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)


