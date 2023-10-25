-- SQL_GET_REPORT
SELECT a.SeqNo ,a.得意先コード ,COALESCE(b.郵便番号1,'') AS 郵便番号1 ,COALESCE(b.郵便番号2,'') AS 郵便番号2 ,COALESCE(b.住所1,'') AS 住所1 ,COALESCE(b.住所2,'') AS 住所2 ,COALESCE(b.得意先名,'') AS 得意先名 ,a.返品日 ,a.品番 ,a.設変番号 ,c.品名 ,a.数量 ,a.単価 ,- a.金額 AS 金額 ,a.備考 FROM T_売上返品 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.SeqNo = ?


