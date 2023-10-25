﻿-- SQL_BASE
SELECT a.管理No ,a.分納No ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,CASE b.受注区分 WHEN '1' THEN '先行手配' WHEN '2' THEN '受注' WHEN '3' THEN '受注' ELSE '再納' END AS 受注区分 ,a.納入日 ,a.依頼日 ,a.出力日 ,c.社員コード ,COALESCE(c.社員名,'') AS 担当者名 ,a.バージョン番号 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.ユーザID = a.更新ユーザ名
-- SQL_OUTPUT
WHERE a.出力日 IS NULL AND a.依頼日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_REPUT
WHERE a.出力日 IS NOT NULL AND a.依頼日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_TARGET
AND ((a.検査区分 = true AND a.検査結果区分 = '0') OR (a.検査区分 = false AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)))
-- SQL_ORDER
AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
-- SQL_NAME
AND c.社員コード = ?
-- SQL_BY
ORDER BY a.依頼日 DESC, b.品番
-- SQL_OUTPUT_DATA
SELECT a.管理No ,a.分納No ,COALESCE(a.出力日,CURRENT_DATE) AS 発行日 ,b.受注番号 ,b.枝番 ,a.振替受注番号 ,a.振替枝番 ,a.振替管理No ,b.品番 ,b.設変番号 ,b.品名 ,CASE WHEN COALESCE(c.棚番2,'') = '' THEN COALESCE(c.棚番1,'') ELSE COALESCE(c.棚番1,'') || '-' || COALESCE(c.棚番2,'') END AS 棚番 ,CASE a.出荷区分 WHEN '0' THEN '先行手配' WHEN '1' THEN '振替出荷' WHEN '2' THEN '在庫出荷' WHEN '3' THEN '通常出荷' ELSE '' END AS 出荷区分 ,COALESCE(f.バケット情報,'') AS 納入バケット ,CASE WHEN g.品番 IS NULL THEN '' ELSE '管理図面' END AS 図面分類 ,a.備考1 ,a.備考2 ,COALESCE(h.作業区コード,'') AS 作業区コード ,COALESCE(k.作業区名,'') AS 作業区名 ,j.受入日 ,b.担当者コード ,COALESCE(l.社員名,'') AS 担当者名 ,b.受注日 ,b.受注数 ,COALESCE(c.在庫数,0) AS 在庫数 ,b.納期 ,a.生産数 ,a.納入日 ,a.依頼数 ,a.回答日 ,a.検査成績書 ,CASE a.出荷便区分 WHEN '1' THEN '赤帽便' WHEN '2' THEN 'ヤマト便' WHEN '3' THEN '佐川便' WHEN '4' THEN '営業届け' WHEN '5' THEN 'その他' ELSE '' END AS 出荷便区分 ,a.梱包区分 ,CASE a.納入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '' END AS 納入形態 ,a.納入場所名 ,b.得意先コード ,COALESCE(o.得意先名,'') AS 得意先名 ,a.出荷区分 ,a.検査区分 ,a.バージョン番号 ,b.テーパーおねじ区分 ,b.検査表添付区分 ,COALESCE(b.客先品番, '') AS 客先品番 ,COALESCE(q.材質名, '') AS 材質名 ,COALESCE(p.梱包方法, '') AS 梱包方法 ,COALESCE(p.梱包時注意事項, '') AS 梱包時注意事項 ,COALESCE(p.客先クレーム履歴, '') AS 客先クレーム履歴 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_在庫 AS c ON c.品番 = b.品番 AND c.設変番号 = b.設変番号 LEFT OUTER JOIN T_購買伝票受注 AS d ON d.帳票番号 = b.注文バーコード番号 LEFT OUTER JOIN T_工号生産納入指示 AS e ON e.発行連番 = b.注文バーコード番号 LEFT OUTER JOIN M_納入バケット AS f ON f.請求元 = b.請求元AND f.次工程コード = b.次工程コード LEFT OUTER JOIN ( SELECT DISTINCT 品番 FROM T_図面 WHERE 図面種類 = '1' ) AS g ON g.品番 = b.品番 LEFT OUTER JOIN T_発注 AS h ON h.管理No = (CASE WHEN a.振替管理No = 0 THEN a.管理No ELSE a.振替管理No END)AND h.最終工程区分 = true LEFT OUTER JOIN ( SELECT 伝票番号, MAX(分納No) AS 分納No FROM T_工程受入 GROUP BY 伝票番号 ) AS i ON i.伝票番号 = h.伝票番号 LEFT OUTER JOIN T_工程受入 AS j ON j.伝票番号 = i.伝票番号 AND j.分納No = i.分納No LEFT OUTER JOIN M_作業区仕入先 AS k ON k.作業区コード = h.作業区コード LEFT OUTER JOIN M_社員 AS l ON l.社員コード = b.担当者コード LEFT OUTER JOIN M_得意先 AS o ON o.得意先コード = b.得意先コード LEFT OUTER JOIN M_梱包 AS p ON p.品番 = b.品番 LEFT OUTER JOIN M_材質 AS q ON q.材質コード = p.材質コード WHERE a.管理No = ? AND a.分納No = ?

