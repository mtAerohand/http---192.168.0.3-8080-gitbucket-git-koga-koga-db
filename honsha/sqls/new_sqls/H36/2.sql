-- SQL_GETALL_SELECT
SELECT a.seq_no ,a.part_no ,a.engineering_change_no ,CASE a.drawing_type WHEN '1' THEN '図面配布' ELSE '設変通知' END AS drawing_type ,CASE a.work_instruction_type WHEN '1' THEN '工程変更' WHEN '2' THEN '製造中止' ELSE '' END AS 作業指示 ,CASE a.wip_type WHEN '1' THEN '使用可' WHEN '2' THEN '修正' WHEN '3' THEN '使用不可' ELSE '' END AS 仕掛品対処 ,a.notice_DATE ,CASE a.is_output WHEN true THEN '有' ELSE '' END AS 発行有無 ,a.issue_DATE ,a.requested_return_DATE ,CASE WHEN a.issue_DATE IS NOT NULL THEN CASE WHEN NOT EXISTS (SELECT * FROM t_drawing_details WHERE seq_no = a.seq_no AND return_DATE IS NULL) THEN '済' ELSE '' END ELSE '' END AS 返却状況 ,a.customer_code ,COALESCE(b.customer_abbreviation,'') AS customer_name ,CASE a.drawing_type WHEN '1' THEN '' ELSE a.new_engineering_change_no END AS new_engineering_change_noFROM t_drawings AS a LEFT OUTER JOIN m_customers AS b ON b.customer_code = a.customer_code

    -- SQL_GETALL_WHERE_NOTICE_DATE
    WHERE a.notice_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE)
        -- SQL_GETALL_WHERE_HINBAN
        AND a.part_no &@ ? AND LENGTH (a.part_no) = LENGTH(?)
        -- SQL_GETALL_WHERE_CUSTOMER_CODE
        AND a.customer_code = ?
        -- SQL_GETALL_WHERE_ZUMEN_TYPE
        AND a.drawing_type = ?
        -- SQL_GETALL_WHERE_TAISHO_1
        AND a.is_output = true AND a.issue_DATE IS NULL
        -- SQL_GETALL_WHERE_TAISHO_2
        AND a.issue_DATE IS NOT NULL AND EXISTS (SELECT * FROM t_drawing_details WHERE seq_no = a.seq_no AND return_DATE IS NULL)
        
    -- SQL_GETALL_WHERE_seq_no
    WHERE a.seq_no = CAST(? as INT)

-- SQL_GETALL_SELECT_ORDER
ORDER BY a.notice_DATE DESC


