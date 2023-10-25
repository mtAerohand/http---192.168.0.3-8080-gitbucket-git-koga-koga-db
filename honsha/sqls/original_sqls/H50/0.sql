-- GET_ALL
SELECT SeqNo ,名称1 ,名称2 ,ヨミガナ ,CASE WHEN 顧客分類= '1' THEN '会社' ELSE '個人' END AS顧客分類 ,郵便番号1 || '-' || 郵便番号2 AS 郵便番号 ,住所1 ,住所2 ,CASE WHEN 年賀対象 = true THEN '有' ELSE '' END AS 年賀対象 ,CASE WHEN 礼状対象 = true THEN '有' ELSE '' END AS 礼状対象 ,CASE WHEN 贈答対象 = true THEN '有' ELSE '' END AS 贈答対象 FROM M_顧客
    -- GET_OPTION
    WHERE 顧客分類 = CAST (? as CHAR)
-- GET_ALL_END
ORDER BY ヨミガナ


