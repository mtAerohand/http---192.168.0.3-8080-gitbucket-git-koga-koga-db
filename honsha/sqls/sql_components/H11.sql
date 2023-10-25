-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(x.管理No) AS INT) FROM (
-- SQL_GET_ALL
SELECT * FROM (
-- SQL_GET_ALL_FROM_CLAUSE
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.受注日 ,a.納期 ,b.登録日 AS 計画作成日 ,CASE WHEN EXISTS (SELECT * FROM T_発注 WHERE 管理No = a.管理No) THEN '済' ELSE '' END AS 発注状況 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,a.得意先コード ,COALESCE(d.得意先略称,'') AS 得意先名 FROM T_受注 AS a LEFT OUTER JOIN T_生産計画 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = a.得意先コード WHERE a.受注区分 <> '2' ) AS x
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE
-- SQL_GET_ALL_WHERE_CLAUSE_ORDER_DATE
x.受注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
AND x.受注番号 &@ ? AND LENGTH(x.受注番号) = LENGTH(?)
-- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
AND x.品番 &@ ? AND LENGTH(x.品番) = LENGTH(?)
-- SQL_GET_ALL_WHERE_CLAUSE_TARGET
AND x.計画作成日 IS NULL
-- SQL_GET_ALL_WHERE_CLAUSE_MANAGEMENT_NO
x.管理No = CAST(? as INT)
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY x.受注日 DESC, 品番
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- SQL_GET_NEW
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,CASE a.再納区分 WHEN '1' THEN '選別依頼' WHEN '2' THEN '再処理' WHEN '3' THEN '再製造' ELSE '' END AS 再納区分 ,a.受注数 ,a.受注日 ,a.納期 AS 客先納期 ,a.単価 ,COALESCE(d.在庫数,0) AS 在庫数 ,COALESCE(d.仮受在庫数,0) AS 仮受在庫数 ,COALESCE(d.在庫数,0) - COALESCE(d.出荷依頼数,0) AS 有効在庫数 ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材質ベース単価,0) ELSE 0 END AS 材質ベース単価（基本） ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材料費,0) ELSE 0 END AS 材料費（基本） ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(f.材質ベース単価,0) ELSE 0 END AS 材質ベース単価 ,a.受注数 AS 生産数 ,0 AS バージョン番号 ,'0' AS 発注状況 ,1 AS 工程順序No ,'' AS 作業区コード ,'' AS 作業区名 ,'' AS 工程コード ,'' AS 工程名 ,0 AS リードタイム ,NULL AS 納期 ,0 AS 発注単価 ,0 AS 加工費区分 ,0 AS 加工費 ,0 AS 材料費区分 ,0 AS 材料費 ,0 AS 詳細バージョン番号 ,0 AS 次回加工費 FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード LEFT OUTER JOIN M_在庫 AS d ON d.品番 = a.品番 AND d.設変番号 = a.設変番号 LEFT OUTER JOIN M_部品 AS e ON e.品番 = a.品番 LEFT OUTER JOIN M_材質ベース単価 AS f ON f.材質コード = e.材質コード AND CURRENT_DATE BETWEEN f.適用開始日 AND f.適用終了日 WHERE a.管理No = CAST(? AS INT)
-- SQL_GET_COPY
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,CASE a.再納区分 WHEN '1' THEN '選別依頼' WHEN '2' THEN '再処理' WHEN '3' THEN '再製造' ELSE '' END AS 再納区分 ,a.受注数 ,a.受注日 ,a.納期 AS 客先納期 ,a.単価 ,COALESCE(d.在庫数,0) AS 在庫数 ,COALESCE(d.仮受在庫数,0) AS 仮受在庫数 ,COALESCE(d.在庫数,0) - COALESCE(d.出荷依頼数,0) AS 有効在庫数 ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材質ベース単価,0) ELSE 0 END AS 材質ベース単価（基本） ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材料費,0) ELSE 0 END AS 材料費（基本） ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(f.材質ベース単価,0) ELSE 0 END AS 材質ベース単価 ,a.受注数 AS 生産数 ,0 AS バージョン番号 ,'0' AS 発注状況 ,h.工程順序No ,h.作業区コード ,COALESCE(i.作業区略称,'') AS 作業区名 ,h.工程コード ,COALESCE(j.工程略称,'') AS 工程名 ,h.リードタイム ,NULL AS 納期 ,CASE WHEN h.次回加工費 <> 0 THEN h.次回加工費 + h.材料費 ELSE h.加工費 + h.材料費 END AS 発注単価 ,h.加工費区分 ,CASE WHEN h.次回加工費 <> 0 THEN h.次回加工費 ELSE h.加工費 END AS 加工費 ,h.材料費区分 ,h.材料費 ,0 AS 詳細バージョン番号 ,e.材料費変動補正対象 ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材料費補正額,0) ELSE 0 END AS 材料費補正額 ,0 AS 次回加工費 FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード LEFT OUTER JOIN M_在庫 AS d ON d.品番 = a.品番 AND d.設変番号 = a.設変番号 LEFT OUTER JOIN M_部品 AS e ON e.品番 = a.品番 LEFT OUTER JOIN M_材質ベース単価 AS f ON f.材質コード = e.材質コード AND CURRENT_DATE BETWEEN f.適用開始日 AND f.適用終了日 CROSS JOIN T_生産計画 AS g INNER JOIN T_生産計画詳細 AS h ON h.管理No = g.管理No LEFT OUTER JOIN M_作業区仕入先 AS i ON i.作業区コード = h.作業区コード LEFT OUTER JOIN M_工程 AS j ON j.工程コード = h.工程コード WHERE a.管理No = CAST(? AS INT) AND g.管理No = CAST(? AS INT) ORDER BY h.工程順序No
-- SQL_GET_EDIT
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' WHEN '4' THEN '再納' ELSE '' END AS 受注区分 ,CASE a.再納区分 WHEN '1' THEN '選別依頼' WHEN '2' THEN '再処理' WHEN '3' THEN '再製造' ELSE '' END AS 再納区分 ,a.受注数 ,a.受注日 ,a.納期 AS 客先納期 ,a.単価 ,COALESCE(d.在庫数,0) AS 在庫数 ,COALESCE(d.仮受在庫数,0) AS 仮受在庫数 ,COALESCE(d.在庫数,0) - COALESCE(d.出荷依頼数,0) AS 有効在庫数 ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材質ベース単価,0) ELSE 0 END AS 材質ベース単価（基本） ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(e.材料費,0) ELSE 0 END AS 材料費（基本） ,CASE WHEN COALESCE(e.材料費変動補正対象,false) = true THEN COALESCE(f.材質ベース単価,0) ELSE 0 END AS 材質ベース単価 ,g.生産数 ,g.バージョン番号 ,CASE WHEN EXISTS (SELECT * FROM T_発注 WHERE 管理No = a.管理No) THEN '1' ELSE '0' END AS 発注状況 ,h.工程順序No ,h.作業区コード ,COALESCE(i.作業区略称,'') AS 作業区名 ,h.工程コード ,COALESCE(j.工程略称,'') AS 工程名 ,h.リードタイム ,h.納期 ,h.加工費 + h.材料費 AS 発注単価 ,h.加工費区分 ,h.加工費 ,h.材料費区分 ,h.材料費 ,h.バージョン番号 AS 詳細バージョン番号 ,h.次回加工費 FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード LEFT OUTER JOIN M_在庫 AS d ON d.品番 = a.品番 AND d.設変番号 = a.設変番号 LEFT OUTER JOIN M_部品 AS e ON e.品番 = a.品番 LEFT OUTER JOIN M_材質ベース単価 AS f ON f.材質コード = e.材質コード AND CURRENT_DATE BETWEEN f.適用開始日 AND f.適用終了日 INNER JOIN T_生産計画 AS g ON g.管理No = a.管理No INNER JOIN T_生産計画詳細 AS h ON h.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS i ON i.作業区コード = h.作業区コード LEFT OUTER JOIN M_工程 AS j ON j.工程コード = h.工程コード WHERE a.管理No = CAST(? AS INT) ORDER BY h.工程順序No
-- SQL_GET_NON_WORKING_DAYS
SELECT 非稼働日 FROM M_カレンダー WHERE 非稼働日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) ORDER BY 非稼働日
-- SQL_GET_HISTORY_LIST
SELECT a.管理No ,a.受注番号 ,a.枝番 ,CASE a.受注区分 WHEN '1' THEN '先行手配' WHEN '3' THEN '受注' ELSE '' END AS 受注区分 ,a.品番 ,a.設変番号 ,b.登録日 AS 計画作成日 ,b.生産数 ,c.発注単価合計 ,d.作業区コード ,COALESCE(e.作業区略称,'') ,d.工程コード ,COALESCE(f.工程略称,'') FROM T_受注 AS a INNER JOIN T_生産計画 AS b ON b.管理No = a.管理No INNER JOIN ( SELECT 管理No, SUM(加工費 + 材料費) AS 発注単価合計 FROM T_生産計画詳細 GROUP BY 管理No ) AS c ON c.管理No = b.管理No INNER JOIN T_生産計画詳細 AS d ON d.管理No = b.管理No AND 工程順序No = 1 LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード LEFT OUTER JOIN M_工程 AS f ON f.工程コード = d.工程コード WHERE a.品番 = ? AND a.受注区分 IN ('1','3') ORDER BY b.登録日 DESC, a.受注番号
-- SQL_CHECK_INSPECTION_SHIPMENT_ACCEPTED
SELECT CASE WHEN EXISTS(SELECT * FROM T_検査出荷依頼 WHERE 管理No = ?) THEN 1 ELSE 0 END AS 判定

