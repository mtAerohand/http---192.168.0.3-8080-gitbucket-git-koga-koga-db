-- SQL_GETALL_COUNT
SELECT CAST(COUNT(seq_no) AS INT) FROM t_drawings AS a

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


