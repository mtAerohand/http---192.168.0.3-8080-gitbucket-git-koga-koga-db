-- SQL_GETALL_COUNT
SELECT CAST(COUNT(SeqNo) AS INT) FROM T_図面 AS a

    -- SQL_GETALL_WHERE_NOTICE_DATE
    WHERE a.通知日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
        -- SQL_GETALL_WHERE_HINBAN
        AND a.品番 &@ ? AND LENGTH (a.品番) = LENGTH(?)
        -- SQL_GETALL_WHERE_CUSTOMER_CODE
        AND a.得意先コード = ?
        -- SQL_GETALL_WHERE_ZUMEN_TYPE
        AND a.図面種類 = ?
        -- SQL_GETALL_WHERE_TAISHO_1
        AND a.出力有無 = true AND a.発行日 IS NULL
        -- SQL_GETALL_WHERE_TAISHO_2
        AND a.発行日 IS NOT NULL AND EXISTS (SELECT * FROM T_図面詳細 WHERE SeqNo = a.SeqNo AND 返却日 IS NULL)
        
    -- SQL_GETALL_WHERE_SEQNO
    WHERE a.SeqNo = CAST(? as INT)


