-- SQL_GET_SELECT
SELECT a.SeqNo ,a.取引先区分 ,a.取引先コード ,CASE WHEN a.取引先区分 = '1' THEN COALESCE(b.得意先名,'') ELSE COALESCE(c.作業区名,'') END AS 取引先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.売上日 ,a.備考 ,a.バージョン番号 FROM T_売上任意 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.取引先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.取引先コード WHERE a.SeqNo = CAST(? as INT)


