-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.管理No) AS INT)
-- SQL_GET_ALL
SELECT a.管理No ,a.得意先コード ,COALESCE(b.得意先略称,'') AS 得意先名 ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,a.受注日 ,a.納期 ,a.受注数 ,a.単価
-- SQL_GET_ALL_FROM_CLAUSE
FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE
-- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
a.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
AND a.受注番号 &@ ? AND LENGTH(a.受注番号) = LENGTH(?)
-- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
AND a.品番 &@ ? AND LENGTH(a.品番) = LENGTH(?)
-- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
a.管理No = CAST(? as INT)
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY a.受注日 DESC, a.品番, a.受注番号
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_CHECK_FOR_DUPLICATE_ORDER_NUMBER
SELECT CAST(COUNT(管理No) AS INT) AS 件数 FROM T_受注 WHERE 受注区分 = ? AND 受注番号 = ? AND 枝番 = ?
-- SQL_CHECK_FOR_DUPLICATE_MANAGEMENT_NUMBER
AND 管理No <> CAST(? as INT)
-- SQL_GET
SELECT a.管理No ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,CASE WHEN a.得意先コード = '1' THEN '1' ELSE '0' END as 得意先区分 ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.品名 ,a.客先品番 ,CASE WHEN c.品番 IS NULL THEN '' ELSE '管理図面' END AS 図面分類 ,a.担当者コード ,COALESCE(d.社員名,'') AS 担当者名 ,a.受注区分 ,a.再納区分 ,a.受注日 ,a.納期 ,a.受注数 ,a.単位 ,a.単価 ,a.納入場所コード ,a.納入場所名 ,CASE a.注文データ区分 WHEN 'A' THEN '' WHEN 'K' THEN COALESCE(f.納入場所コード,'') WHEN 'C' THEN COALESCE(f.納入場所コード,'') ELSE '' END AS 客先納入場所コード ,CASE a.注文データ区分 WHEN 'A' THEN COALESCE(e.納入場所名,'') WHEN 'K' THEN COALESCE(f.納入場所名,'') WHEN 'C' THEN COALESCE(f.納入場所名,'') ELSE '' END AS 客先納入場所名 ,a.次工程コード ,a.次工程名 ,CASE a.注文データ区分 WHEN 'A' THEN COALESCE(e.次工程先コード,'') WHEN 'K' THEN COALESCE(f.次工程先コード,'') WHEN 'C' THEN COALESCE(f.次工程先コード,'') ELSE '' END AS 客先次工程コード ,CASE a.注文データ区分 WHEN 'A' THEN COALESCE(e.次工程名,'') WHEN 'K' THEN COALESCE(f.次工程名,'') WHEN 'C' THEN COALESCE(f.次工程名,'') ELSE '' END AS 客先次工程名 ,a.請求元 ,COALESCE(g.バケット情報,'') AS 納入バケット ,'' AS 梱包区分 ,a.発注備考1 ,a.発注備考区分1 ,a.発注備考2 ,a.発注備考区分2 ,a.依頼備考1 ,a.依頼備考区分1 ,a.依頼備考2 ,a.依頼備考区分2 ,a.納入備考1 ,a.納入備考2 ,a.バージョン番号 ,a.テーパーおねじ区分 ,CASE a.注文データ区分 WHEN 'A' THEN COALESCE(CASE e.支給予定日 WHEN '0' THEN '' WHEN '00000000' THEN '' ELSE e.支給予定日 END,'') WHEN 'K' THEN COALESCE(CASE f.支給予定日 WHEN '0' THEN '' WHEN '00000000' THEN '' ELSE f.支給予定日 END,'') WHEN 'C' THEN COALESCE(CASE f.支給予定日 WHEN '0' THEN '' WHEN '00000000' THEN '' ELSE f.支給予定日 END,'') ELSE '' END AS 支給予定日 ,a.検査表添付区分 FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN ( SELECT DISTINCT 品番 FROM T_図面 WHERE 図面種類 = '1' ) AS c ON c.品番 = a.品番 LEFT OUTER JOIN M_社員 AS d ON d.社員コード = a.担当者コード LEFT OUTER JOIN T_購買伝票受注 AS e ON e.帳票番号 = a.注文バーコード番号 LEFT OUTER JOIN T_工号生産納入指示 AS f ON f.発行連番 = a.注文バーコード番号 LEFT OUTER JOIN M_納入バケット AS g ON g.請求元 = a.請求元 AND g.次工程コード = a.次工程コード WHERE 管理No = CAST(? as INT)
-- SQL_GET_COPY
SELECT a.管理No ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,CASE WHEN a.得意先コード = '1' THEN '1' ELSE '0' END as 得意先区分 ,'' AS 受注番号 ,'' AS 枝番 ,a.品番 ,a.設変番号 ,a.品名 ,a.客先品番 ,CASE WHEN c.品番 IS NULL THEN '' ELSE '管理図面' END AS 図面分類 ,a.担当者コード ,COALESCE(d.社員名,'') AS 担当者名 ,a.受注区分 ,a.再納区分 ,NULL AS 受注日 ,NULL AS 納期 ,a.受注数 ,a.単位 ,a.単価 ,a.納入場所コード ,a.納入場所名 ,'' AS 客先納入場所コード ,'' AS 客先納入場所名 ,a.次工程コード ,a.次工程名 ,'' AS 客先次工程コード ,'' AS 客先次工程名 ,a.請求元 ,COALESCE(e.バケット情報,'') AS 納入バケット ,'' AS 梱包区分 ,CASE WHEN a.発注備考区分1 = true THEN '' ELSE a.発注備考1 END AS 発注備考1 ,0 AS 発注備考区分1 ,CASE WHEN a.発注備考区分2 = true THEN '' ELSE a.発注備考2 END AS 発注備考2 ,0 AS 発注備考区分2 ,CASE WHEN a.依頼備考区分1 = true THEN '' ELSE a.依頼備考1 END AS 依頼備考1 ,0 AS 依頼備考区分1 ,CASE WHEN a.依頼備考区分2 = true THEN '' ELSE a.依頼備考2 END AS 依頼備考2 ,0 AS 依頼備考区分2 ,'' AS 納入備考1 ,'' AS 納入備考2 ,a.バージョン番号 ,a.テーパーおねじ区分 ,'' AS 支給予定日 ,a.検査表添付区分 FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN T_図面 AS c ON c.品番 = a.品番 AND c.図面種類 = '1' LEFT OUTER JOIN M_社員 AS d ON d.社員コード = a.担当者コード LEFT OUTER JOIN M_納入バケット AS e ON e.請求元 = a.請求元 AND e.次工程コード = a.次工程コード WHERE 管理No = CAST(? as INT)
-- SQL_GET_PLAN_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM T_生産計画 WHERE 管理No = ?) THEN 1 ELSE 0 END AS 判定
-- SQL_GET_DELIVERY_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM T_納期回答 WHERE 管理No = ?) THEN 1 ELSE 0 END AS 判定

