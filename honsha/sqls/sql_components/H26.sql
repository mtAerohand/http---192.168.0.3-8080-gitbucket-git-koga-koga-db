﻿-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.仕入先コード ,CASE WHEN a.取引分類 = '1' THEN '材料' ELSE 'その他' END AS 取引分類 ,a.取引日 AS 仕入日 ,CASE WHEN a.取引分類 = '1' THEN a.材質名 ELSE a.品番 END AS 材質品番 ,CASE WHEN a.取引分類 = '1' THEN '' ELSE a.設変番号 END AS 設変番号 ,CASE WHEN a.取引分類 = '1' THEN a.形状 ELSE a.品名 END AS 形状品名 ,a.重量 ,a.数量 ,a.単価 ,a.金額 ,a.支給先コード ,COALESCE(b.作業区略称,'') AS 支給先名 FROM T_仕入 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.支給先コード
-- SQL_GETALL_WHERE
WHERE a.取引区分 = '1' AND a.仕入先コード = ? AND a.取引日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GETALL_WHERE_SEQNO
WHERE a.SeqNo = CAST(? AS INT)
-- SQL_GETALL_ORDERBY
ORDER BY a.取引日 DESC, 材質品番, 設変番号, 形状品名
-- SQL_GETALL_COUNT
SELECT CAST(COUNT(a.SeqNo) AS INT) FROM T_仕入 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.支給先コード WHERE a.取引区分 = '1' AND a.仕入先コード = ? AND a.取引日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GET_SELECT
SELECT a.SeqNo ,a.仕入先コード ,COALESCE(b.作業区名,'') AS 仕入先名 ,a.取引分類 ,a.材質名 ,a.形状 ,a.重量 ,a.材料単位 ,a.品番 ,a.設変番号 ,a.品名 ,a.数量 ,a.単価 ,a.金額 ,a.支給先コード ,COALESCE(c.作業区名,'') AS 支給先名 ,a.支給金額 ,a.取引日 ,a.備考 ,a.バージョン番号 ,a.相殺方法 ,d.相殺日 ,d.重量 ,d.相殺金額 FROM T_仕入 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.仕入先コード LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.支給先コード LEFT OUTER JOIN T_仕入相殺 AS d ON d.SeqNo = a.SeqNo WHERE a.SeqNo = CAST(? AS INT) ORDER BY d.相殺SeqNo
-- SQL_EXISTS_SELECT_ZAIRYOU
SELECT CASE WHEN EXISTS(SELECT * FROM T_仕入 WHERE 取引区分 = '1' AND 取引分類 = '1' AND 仕入先コード = ? AND 材質名 = ? AND 形状 = ? AND 取引日 = CAST(? as DATE) %s ) THEN 1 ELSE 0 END AS 判定
-- SQL_EXISTS_SELECT_SONOTA
SELECT CASE WHEN EXISTS(SELECT * FROM T_仕入 WHERE 取引区分 = '1' AND 取引分類 = '2' AND 仕入先コード = ? AND 品番 = ? AND 設変番号 = ? AND 取引日 = CAST(? as DATE) %s) THEN 1 ELSE 0 END AS 判定
-- SQL_EXISTS_WHERE_UPDATE
AND SeqNo <> CAST(? AS INT)

