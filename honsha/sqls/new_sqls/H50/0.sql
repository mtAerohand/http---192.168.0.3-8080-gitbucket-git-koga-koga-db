-- GET_ALL
SELECT seq_no ,name_1 ,name_2 ,kana ,CASE WHEN client_type= '1' THEN '会社' ELSE '個人' END ASclient_type ,zip_code_1 || '-' || zip_code_2 AS 郵便番号 ,address_1 ,address_2 ,CASE WHEN has_nenga = true THEN '有' ELSE '' END AS has_nenga ,CASE WHEN has_reijo = true THEN '有' ELSE '' END AS has_reijo ,CASE WHEN has_gift = true THEN '有' ELSE '' END AS has_gift FROM m_clients
    -- GET_OPTION
    WHERE client_type = CAST (? as CHAR)
-- GET_ALL_END
ORDER BY kana


