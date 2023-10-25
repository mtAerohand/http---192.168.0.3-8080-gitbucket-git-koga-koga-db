-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(A.管理No) AS INT)
-- SQL_GET_ALL_EDIT_FROM
FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = b.得意先コード WHERE a.依頼日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) AND ((a.検査区分 = true AND a.検査結果区分 = '0') OR (a.検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)) )
    -- 836
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
    -- 838
    AND b.担当者コード = ?

    -- 836
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)

    -- 838
    AND b.担当者コード = ?
