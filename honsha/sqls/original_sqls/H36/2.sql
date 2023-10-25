-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.品番 ,a.設変番号 ,CASE a.図面種類 WHEN '1' THEN '図面配布' ELSE '設変通知' END AS 図面種類 ,CASE a.作業指示区分 WHEN '1' THEN '工程変更' WHEN '2' THEN '製造中止' ELSE '' END AS 作業指示 ,CASE a.仕掛品対処区分 WHEN '1' THEN '使用可' WHEN '2' THEN '修正' WHEN '3' THEN '使用不可' ELSE '' END AS 仕掛品対処 ,a.通知日 ,CASE a.出力有無 WHEN true THEN '有' ELSE '' END AS 発行有無 ,a.発行日 ,a.返却希望日 ,CASE WHEN a.発行日 IS NOT NULL THEN CASE WHEN NOT EXISTS (SELECT * FROM T_図面詳細 WHERE SeqNo = a.SeqNo AND 返却日 IS NULL) THEN '済' ELSE '' END ELSE '' END AS 返却状況 ,a.得意先コード ,COALESCE(b.得意先略称,'') AS 得意先名 ,CASE a.図面種類 WHEN '1' THEN '' ELSE a.新設変番号 END AS 新設変番号FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード

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

-- SQL_GETALL_SELECT_ORDER
ORDER BY a.通知日 DESC


