-- SQL_GETALL_COUNT
SELECT CAST(COUNT(SeqNo) AS INT) FROM T_図面 AS a
-- SQL_REPORT
SELECT a.SeqNo, a.図面種類, a.品番, COALESCE(c.品名,'') AS 品名, a.設変番号, a.新設変番号, a.返却希望日, a.備考, b.作業区コード, COALESCE(d.作業区名,'') AS 作業区名 FROM T_図面 AS a INNER JOIN T_図面詳細 AS b ON b.SeqNo = a.SeqNo AND b.返却日 IS NULL LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN M_作業区仕入先 AS d ON d.作業区コード = b.作業区コード WHERE a.SeqNo = ? AND a.出力有無 = true ORDER BY b.工程順序No
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GETALL_SELECT
SELECT a.SeqNo ,a.品番 ,a.設変番号 ,CASE a.図面種類 WHEN '1' THEN '図面配布' ELSE '設変通知' END AS 図面種類 ,CASE a.作業指示区分 WHEN '1' THEN '工程変更' WHEN '2' THEN '製造中止' ELSE '' END AS 作業指示 ,CASE a.仕掛品対処区分 WHEN '1' THEN '使用可' WHEN '2' THEN '修正' WHEN '3' THEN '使用不可' ELSE '' END AS 仕掛品対処 ,a.通知日 ,CASE a.出力有無 WHEN true THEN '有' ELSE '' END AS 発行有無 ,a.発行日 ,a.返却希望日 ,CASE WHEN a.発行日 IS NOT NULL THEN CASE WHEN NOT EXISTS (SELECT * FROM T_図面詳細 WHERE SeqNo = a.SeqNo AND 返却日 IS NULL) THEN '済' ELSE '' END ELSE '' END AS 返却状況 ,a.得意先コード ,COALESCE(b.得意先略称,'') AS 得意先名 ,CASE a.図面種類 WHEN '1' THEN '' ELSE a.新設変番号 END AS 新設変番号FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード
-- SQL_GETALL_SELECT_ORDER
ORDER BY a.通知日 DESC
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
-- SQL_GET_SELECT
SELECT a.SeqNo ,a.図面種類 ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.通知日 ,a.設変管理No ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.新設変番号 ,a.作業指示区分 ,a.仕掛品対処区分 ,a.備考 ,a.出力有無 ,a.返却希望日 ,a.バージョン番号 ,d.工程順序No ,d.作業区コード ,COALESCE(e.作業区略称,'') AS 作業区名 ,d.返却日 ,d.バージョン番号 AS 詳細バージョン番号 FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN T_図面詳細 AS d ON d.SeqNo = a.SeqNo LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード WHERE a.SeqNo = CAST(? as INT) ORDER BY d.工程順序No
-- SQL_GET_WORKREGION_SELECT
SELECT B.作業区コード, COALESCE(C.作業区略称,'') AS 作業区名 FROM ( SELECT b.管理No FROM ( SELECT 品番, MAX(受注日) AS 受注日 FROM T_受注 AS x WHERE 品番 = ? AND EXISTS (SELECT * FROM T_生産計画 WHERE 管理No = x.管理No) GROUP BY 品番 ) AS a INNER JOIN T_受注 AS b ON b.品番 = a.品番 AND b.受注日 = a.受注日 AND EXISTS (SELECT * FROM T_生産計画 WHERE 管理No = b.管理No) LIMIT 1 ) AS A INNER JOIN T_生産計画詳細 AS B ON B.管理No = A.管理No LEFT OUTER JOIN M_作業区仕入先 AS C ON C.作業区コード = B.作業区コード ORDER BY B.工程順序No
-- SQL_ADD_ZUMEN_EXISTS
SELECT CAST(COUNT(SeqNo) AS INT) AS 件数 FROM T_図面 WHERE 図面種類 = ? AND 品番 = ? AND (CASE WHEN 図面種類 = '1' THEN 設変番号 ELSE 新設変番号 END) = ?
-- SQL_UPDATE_ZUMEN_EXISTS_WHERE
AND SeqNo <> CAST(? as INT) --訂正の場合

