-- SQL_GET
SELECT a.SeqNo ,a.件名 ,a.内容 ,a.連絡日 ,a.更新者コード ,b.社員名 FROM M_お知らせ AS a LEFT OUTER JOIN M_社員 AS b ON b.社員コード = a.更新者コード ORDER BY a.連絡日 DESC LIMIT 1

