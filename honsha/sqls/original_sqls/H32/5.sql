-- SQL_GET_REPLY_MAIL
SELECT a.管理No ,b.得意先コード ,COALESCE(d.得意先名,'') AS 得意先名 ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,b.品名 ,a.回答日 ,c.分納No ,c.回答日 AS 分納回答日 ,c.予定納入数 FROM ( SELECT 管理No ,MIN(回答日) AS 回答日 FROM T_納期回答 WHERE 回答日 IS NOT NULL GROUP BY 管理No ) AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_納期回答 AS c ON c.管理No = a.管理No AND c.回答日 IS NOT NULL LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = b.得意先コード WHERE a.管理No = CAST(? as INT)


