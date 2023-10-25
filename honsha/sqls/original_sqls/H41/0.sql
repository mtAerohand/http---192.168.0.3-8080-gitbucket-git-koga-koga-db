-- SQL_SELECT_COUNT
SELECT CAST(COUNT(a.SeqNo) AS INT)
-- SQL_WHERE
FROM T_現品票 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN ( SELECT データSeqNo ,MAX(送信データ作成日) AS 送信データ作成日 FROM T_SMC送信 WHERE データ分類コード = 1 GROUP BY データSeqNo ) AS c ON c.データSeqNo = a.SeqNo WHERE a.有効区分 = false AND a.印刷日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
    -- SQL_WHERE_OPTION1
    AND c.送信データ作成日 IS NULL
    
    -- SQL_WHERE_OPTION2
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)


