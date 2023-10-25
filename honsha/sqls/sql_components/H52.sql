-- SQL_REPORT_LIMIT
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = '1' AND Key2 = 'H52' AND Key3 in ('1','2')
-- SQL_REPORT_21_COUNT_TEMPLATE
SELECT CAST(COUNT(a.作業区コード) AS INT) %s %s %s
-- SQL_REPORT_21_SELECT_TEMPLATE
SELECT CASE WHEN a.納期 < CURRENT_DATE THEN '*' ELSE '' END AS 遅れ ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(c.工程略称,'') AS 工程名 ,d.受注番号 ,d.枝番 ,d.品番 ,d.設変番号 ,d.品名 ,a.発注日 ,a.納期 ,a.発注数 ,a.単価 ,CAST(TRUNC(a.単価 * a.発注数,0) as BIGINT) AS 発注金額 ,a.発注数 - COALESCE(e.総受入数,0) AS 発注残数 ,CAST(TRUNC(a.単価 * ( a.発注数 - COALESCE(e.総受入数,0)),0) as BIGINT) AS 発注残金額 ,d.得意先コード ,f.得意先略称 ,CASE WHEN g.回答日 IS NOT NULL THEN CAST(DATE_PART('YEAR',g.回答日) as VARCHAR) || '/' || CAST(DATE_PART('MONTH',g.回答日) as VARCHAR) || '/' || CAST(DATE_PART('DAY',g.回答日) as VARCHAR) ELSE '' END AS 回答日 ,COALESCE(g.希望納入数,0) AS 回答数 ,a.伝票番号 %s %s %s %s
-- SQL_REPORT_21_COMMON
FROM T_発注 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS c ON c.工程コード = a.工程コード INNER JOIN T_受注 AS d ON d.管理No = a.管理No LEFT OUTER JOIN ( SELECT 伝票番号 ,SUM(受入数) AS 総受入数 FROM T_工程受入 GROUP BY 伝票番号 ) AS e ON e.伝票番号 = a.伝票番号 LEFT OUTER JOIN M_得意先 AS f ON f.得意先コード = d.得意先コード LEFT OUTER JOIN ( SELECT 管理No ,工程順序No ,回答日 ,希望納入数 FROM T_納期回答依頼 WHERE 回答日 IS NOT NULL ) AS g ON g.管理No = a.管理No AND g.工程順序No = a.工程順序No WHERE a.作業区コード = ? AND a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 伝票番号 = a.伝票番号 AND 受入形態区分 IN ('1','2'))
-- SQL_REPORT_21_WHERE_TOKUISAKI
AND d.得意先コード = ?
-- SQL_REPORT_21_WHERE_HINBANI
AND d.品番 &^ ?
-- SQL_REPORT_21_ORDERBY
ORDER BY d.品番, a.納期, g.回答日
-- SQL_REPORT_22_SELECT_TEMPLATE
SELECT CASE WHEN C.作業区分類 = '1' THEN '社内' ELSE '協力' END AS 区分 ,A.作業区コード ,COALESCE(C.作業区名,'') AS 作業区名 ,A.発注件数 ,A.発注金額 ,COALESCE(B.発注残件数,0) AS 発注残件数 ,COALESCE(B.発注残金額,0) AS 発注残金額 ,COALESCE(D.発注残金額,0) AS 実質発注残金額 %s %s
-- SQL_REPORT_22_COMMON
FROM( SELECT 作業区コード ,CAST(COUNT(作業区コード) AS INT) AS 発注件数 ,CAST(SUM(TRUNC(単価 * 発注数,0)) AS BIGINT) AS 発注金額 FROM T_発注 WHERE 納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) GROUP BY 作業区コード ) AS A LEFT OUTER JOIN ( SELECT x.作業区コード ,CAST(COUNT(x.作業区コード) AS INT) AS 発注残件数 ,CAST(SUM(x.発注残金額) AS BIGINT) AS 発注残金額 FROM ( SELECT a.作業区コード ,CAST(TRUNC(a.単価 * (a.発注数 - COALESCE(b.完了数,0)),0) as BIGINT) AS 発注残金額 FROM T_発注 AS a LEFT OUTER JOIN ( SELECT 伝票番号 ,SUM(受入数) AS 完了数 FROM T_工程受入 GROUP BY 伝票番号 ) as b ON b.伝票番号 = a.伝票番号 WHERE a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 伝票番号 = a.伝票番号 AND 受入形態区分 IN ('1','2')) ) AS x GROUP BY x.作業区コード ) AS B ON B.作業区コード = A.作業区コード LEFT OUTER JOIN M_作業区仕入先 AS C ON C.作業区コード = A.作業区コード LEFT OUTER JOIN ( SELECT y.作業区コード ,CAST(SUM(y.発注残金額) AS BIGINT) AS 発注残金額 FROM ( SELECT x.作業区コード ,CASE WHEN x.工程順序No = 1 THEN CAST(TRUNC(x.単価 * (x.発注数 - x.自工程完了数),0) as BIGINT) ELSE CASE WHEN x.前工程完了数 > 0 THEN CASE WHEN x.前工程完了数 > x.自工程完了数 THEN CAST(TRUNC(x.単価 * (x.前工程完了数 - x.自工程完了数),0) as BIGINT) ELSE 0 END ELSE CASE WHEN x.自工程完了数 > 0 THEN CAST(TRUNC(x.単価 * (x.発注数 - x.自工程完了数),0) as BIGINT) ELSE CASE WHEN x.回答日有無 = 1 THEN CAST(TRUNC(x.単価 * x.発注数,0) as BIGINT) ELSE 0 END END END END AS 発注残金額 FROM ( SELECT a.伝票番号 ,a.管理No ,a.工程順序No ,a.作業区コード ,a.発注日 ,a.発注数 ,a.単価 ,CASE WHEN EXISTS (SELECT * FROM T_納期回答依頼 WHERE 管理No = a.管理No AND 工程順序No = (a.工程順序No - 1) AND 回答日 IS NOT NULL) THEN 1 ELSE 0 END AS 回答日有無 ,COALESCE(b.前工程完了数,0) AS 前工程完了数 ,COALESCE(c.自工程完了数,0) AS 自工程完了数 FROM T_発注 AS a LEFT OUTER JOIN ( SELECT 管理No ,工程順序No ,SUM(受入数) AS 前工程完了数 FROM T_工程受入 GROUP BY 管理No, 工程順序No ) AS b ON b.管理No = a.管理No AND b.工程順序No = (a.工程順序No - 1) LEFT OUTER JOIN ( SELECT 伝票番号 ,SUM(受入数) AS 自工程完了数 FROM T_工程受入 GROUP BY 伝票番号 ) AS c ON c.伝票番号 = a.伝票番号 WHERE a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 伝票番号 = a.伝票番号 AND 受入形態区分 IN ('1','2')) ) AS x ) AS y GROUP BY y.作業区コード ) AS D ON D.作業区コード = A.作業区コード
-- SQL_REPORT_22_COUNT_TEMPLATE
SELECT CAST(COUNT(A.作業区コード) AS INT) %s %s
-- SQL_REPORT_22_ORDERBY
ORDER BY COALESCE(C.表示順,0), A.作業区コード
-- SQL_REPORT_23_SELECT_TEMPLATE
SELECT c.作業区コード ,COALESCE(d.作業区名,'') AS 作業区名 ,b.品番 ,b.設変番号 ,b.品名 ,c.工程コード ,COALESCE(e.工程略称,'') AS 工程名 ,a.希望納入数 ,a.分納No ,b.受注番号 ,b.枝番 %s %s
-- SQL_REPORT_23_COUNT_TEMPLATE
SELECT CAST(COUNT(c.作業区コード) AS INT) %s %s
-- SQL_REPORT_23_COMMON
FROM T_納期回答依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_生産計画詳細 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS d ON d.作業区コード = c.作業区コード LEFT OUTER JOIN M_工程 AS e ON e.工程コード = c.工程コード WHERE a.回答日 IS NOT NULL AND a.回答日 = CAST(? as DATE) AND EXISTS (SELECT * FROM T_発注 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No AND 分納No = a.分納No)
-- SQL_REPORT_23_ORDERBY
ORDER BY COALESCE(d.表示順,0), c.作業区コード, b.品番
-- SQL_REPORT_62_ALL
SELECT a.品番 ,a.設変番号 ,a.品名 ,a.在庫数 ,CAST((COALESCE(c.単価,0) * COALESCE(d.在庫製品評価率,0) / 100) as NUMERIC(12,2)) AS 評価単価 ,CAST(TRUNC(CAST((COALESCE(c.単価,0) * COALESCE(d.在庫製品評価率,0) / 100) as NUMERIC(12,2)) * a.在庫数,0) as BIGINT) AS 在庫金額 FROM M_在庫 AS a LEFT OUTER JOIN ( SELECT 品番, 設変番号, MIN(単価) AS 単価 FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号 ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT q.品番 ,q.設変番号 ,CASE WHEN CURRENT_DATE - interval'1 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率1 WHEN CURRENT_DATE - interval'2 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率2 WHEN CURRENT_DATE - interval'3 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率3 WHEN CURRENT_DATE - interval'5 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率4 ELSE p.在庫製品評価率5 END AS 在庫製品評価率 FROM ( SELECT 品番, 設変番号, MAX(受注日) AS 受注日 FROM T_受注 GROUP BY 品番, 設変番号 ) AS q LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(x.納入日) AS 納入日 FROM T_売上 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS o ON o.品番 = q.品番 AND o.設変番号 = q.設変番号 INNER JOIN M_システム AS p ON p.SeqNo = 1 ) AS d ON d.品番 = a.品番 AND d.設変番号 = a.設変番号 WHERE a.在庫数 <> 0 %s
-- SQL_REPORT_62_GOUKEI
SELECT SUM(x.在庫数) AS 在庫数計 ,SUM(x.在庫金額) AS 在庫金額計 FROM ( SELECT a.在庫数 ,CAST(TRUNC(CAST((COALESCE(c.単価,0) * COALESCE(d.在庫製品評価率,0) / 100) as NUMERIC(12,2)) * a.在庫数,0) as BIGINT) AS 在庫金額 FROM M_在庫 AS a LEFT OUTER JOIN ( SELECT 品番, 設変番号, MIN(単価) AS 単価 FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号 ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT q.品番 ,q.設変番号 ,CASE WHEN CURRENT_DATE - interval'1 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率1 WHEN CURRENT_DATE - interval'2 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率2 WHEN CURRENT_DATE - interval'3 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率3 WHEN CURRENT_DATE - interval'5 year' < COALESCE(o.納入日,q.受注日) THEN p.在庫製品評価率4 ELSE p.在庫製品評価率5 END AS 在庫製品評価率 FROM ( SELECT 品番, 設変番号, MAX(受注日) AS 受注日 FROM T_受注 GROUP BY 品番, 設変番号 ) AS q LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(x.納入日) AS 納入日 FROM T_売上 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS o ON o.品番 = q.品番 AND o.設変番号 = q.設変番号 INNER JOIN M_システム AS p ON p.SeqNo = 1 ) AS d ON d.品番 = a.品番 AND d.設変番号 = a.設変番号 WHERE a.在庫数 <> 0 ) AS x %s
-- SQL_REPORT_62_ORDER_BY
ORDER BY a.品番, a.設変番号
-- SQL_REPORT_63_CHOKKIN_TANAOROSHIGETSU
SELECT MAX(棚卸月) AS 直近棚卸月 FROM T_棚卸
-- SQL_REPORT_63_ALL
SELECT a.棚卸月 ,a.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,a.仕掛品金額 + a.材料金額 AS 在庫金額 ,a.仕掛品金額 ,a.材料金額 FROM ( SELECT x.棚卸月 ,x.作業区コード ,SUM(x.仕掛品金額) AS 仕掛品金額 ,SUM(x.材料金額) AS 材料金額 FROM ( SELECT 棚卸月 ,作業区コード ,CASE 分類 WHEN '1' THEN 金額 ELSE 0 END AS 仕掛品金額 ,CASE 分類 WHEN '1' THEN 0 ELSE 金額 END AS 材料金額 FROM T_棚卸 ) AS x GROUP BY x.棚卸月, x.作業区コード ) AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE a.棚卸月 = ? ORDER BY COALESCE(b.表示順,0), a.作業区コード
-- SQL_REPORT_63_SHOUSAI
SELECT a.棚卸月 ,a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,CASE a.分類 WHEN '1' THEN '仕掛品' ELSE '材料' END AS 分類 ,CASE a.分類 WHEN '1' THEN a.品番 ELSE a.材質名 END AS 品番材質 ,CASE a.分類 WHEN '1' THEN a.設変番号 ELSE '' END AS 設変番号 ,CASE a.分類 WHEN '1' THEN COALESCE(c.品名,'') ELSE a.形状 END AS 品名形状 ,CASE a.分類 WHEN '1' THEN a.数量 ELSE a.重量 END AS 数量 ,a.単価 ,CASE a.分類 WHEN '1' THEN a.評価率 ELSE NULL END AS 評価率 ,CASE a.分類 WHEN '1' THEN a.評価単価 ELSE NULL END AS 評価単価 ,a.金額 FROM T_棚卸 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 WHERE a.棚卸月 = ? %s %s
-- SQL_REPORT_63_SHOUSAI_SHIIRESAKI
AND a.作業区コード = ?
-- SQL_REPORT_63_SHOUSAI_SAGYOUKU_ORDER_BY
ORDER BY COALESCE(b.表示順,0), a.作業区コード, a.分類, 品番材質, 設変番号, 品名形状
-- SQL_REPORT_31_COUNT_TEMPLATE
SELECT CAST(COUNT(x.得意先コード) AS INT) %s %s
-- SQL_REPORT_31_SELECT_TEMPLATE
SELECT x.データ種別 ,x.得意先コード ,COALESCE(y.得意先名,'') AS 得意先名 ,x.区分 ,x.分類 ,x.受注番号 ,x.枝番 ,x.品番 ,x.設変番号 ,x.品名 ,x.客先品番 ,x.納入日 ,x.納入場所名 ,x.返品日 ,x.納期 ,x.数量 ,x.単価 ,x.金額 ,x.納入形態 ,x.発行連番 %s %s %s
-- SQL_REPORT_31_COMMON
FROM ( SELECT 1 AS データ種別 ,b1.得意先コード ,'売上' AS 区分 ,'' AS 分類 ,b1.受注番号 ,b1.枝番 ,b1.品番 ,b1.設変番号 ,b1.品名 ,b1.客先品番 ,a1.納入日 ,b1.納入場所名 ,CAST(NULL AS DATE) AS 返品日 ,b1.納期 ,a1.依頼数 AS 数量 ,a1.単価 ,a1.金額 ,CASE a1.納入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' ELSE '' END AS 納入形態 ,'' AS 発行連番 FROM T_売上 AS a1 INNER JOIN T_受注 AS b1 ON b1.管理No = a1.管理No AND b1.受注区分 IN ('2','3') AND NOT (b1.得意先コード = '1' AND LEFT(b1.受注番号,1) ~ '^[0-9]+$') WHERE a1.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT 2 AS データ種別 ,b2.得意先コード ,'売上' AS 区分 ,'工号' AS 分類 ,b2.受注番号 ,b2.枝番 ,b2.品番 ,b2.設変番号 ,b2.品名 ,b2.客先品番 ,a2.納入日 ,b2.納入場所名 ,CAST(NULL AS DATE) AS 返品日 ,b2.納期 ,a2.依頼数 AS 数量 ,a2.単価 ,a2.金額 ,CASE a2.納入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' ELSE '' END AS 納入形態 ,c2.発行連番 FROM T_売上 AS a2 INNER JOIN T_受注 AS b2 ON b2.管理No = a2.管理No LEFT OUTER JOIN T_工号生産納入指示 AS c2 ON c2.発行連番 = b2.注文バーコード番号 WHERE a2.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND b2.受注区分 IN ('2','3') AND b2.得意先コード = '1' AND LEFT(b2.受注番号,1) ~ '^[0-9]+$' AND ((b2.納期 >= '2018-01-01' AND COALESCE(c2.次工程先コード,'') <> '') OR b2.納期 <= '2017-12-31') UNION ALL SELECT 2 AS データ種別 ,b3.得意先コード ,'売上' AS 区分 ,'工号' AS 分類 ,b3.受注番号 ,b3.枝番 ,b3.品番 ,b3.設変番号 ,b3.品名 ,b3.客先品番 ,a3.納入日 ,b3.納入場所名 ,CAST(NULL AS DATE) AS 返品日 ,b3.納期 ,a3.依頼数 AS 数量 ,a3.単価 ,a3.金額 ,CASE a3.納入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' ELSE '' END AS 納入形態 ,c3.発行連番 FROM T_売上 AS a3 INNER JOIN T_受注 AS b3 ON b3.管理No = a3.管理No AND b3.受注区分 IN ('2','3') AND b3.得意先コード = '1' AND LEFT(b3.受注番号,1) ~ '^[0-9]+$' AND b3.納期 >= '2018-01-01' LEFT OUTER JOIN T_工号生産納入指示 AS c3 ON c3.発行連番 = b3.注文バーコード番号 WHERE a3.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND COALESCE(c3.次工程先コード,'') = '' UNION ALL SELECT 4 AS データ種別 ,a4.得意先コード ,'返品' AS 区分 ,'' AS 分類 ,'' AS 受注番号 ,'' AS 枝番 ,a4.品番 ,a4.設変番号 ,COALESCE(b4.品名,'') AS 品名 ,'' AS 客先品番 ,CAST(NULL AS DATE) AS 納入日 ,'' AS 納入場所名 ,a4.返品日 ,CAST(NULL AS DATE) AS 納期 ,- a4.数量 AS 数量 ,a4.単価 ,- a4.金額 AS 金額 ,'' AS 納入形態 ,'' AS 発行連番 FROM T_売上返品 AS a4 LEFT OUTER JOIN M_部品 AS b4 ON b4.品番 = a4.品番 WHERE a4.返品日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT 5 AS データ種別 ,a5.取引先コード ,'売上' AS 区分 ,'' AS 分類 ,'' AS 受注番号 ,'' AS 枝番 ,a5.品番 ,a5.設変番号 ,a5.品名 ,'' AS 客先品番 ,a5.売上日 AS 納入日 ,'' AS 納入場所名 ,CAST(NULL AS DATE) AS 返品日 ,CAST(NULL AS DATE) AS 納期 ,a5.数量 ,a5.単価 ,a5.金額 ,'' AS 納入形態 ,'' AS 発行連番 FROM T_売上任意 AS a5 WHERE a5.売上日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND a5.取引先区分 = '1' ) AS x LEFT OUTER JOIN M_得意先 AS y ON y.得意先コード = x.得意先コード WHERE x.得意先コード = ?
-- SQL_REPORT_31_WHERE_HINBAN
AND x.品番 &^ ?
-- SQL_REPORT_31_ORDERBY
ORDER BY CASE データ種別 WHEN 4 THEN x.返品日 ELSE x.納入日 END ,x.データ種別 ,x.品番 ,x.受注番号
-- SQL_REPORT_32_COUNT_TEMPLATE
SELECT CAST(COUNT(x.得意先コード) AS INT) %s %s
-- SQL_REPORT_32_SELECT_TEMPLATE
SELECT x.得意先コード ,COALESCE(y.得意先名,'') AS 得意先名 ,x.件数 ,x.売上金額 %s %s
-- SQL_REPORT_32_COMMON
FROM ( SELECT A.得意先コード ,CAST(COUNT(A.得意先コード) AS INT) AS 件数 ,SUM(A.金額) AS 売上金額 FROM ( SELECT b1.得意先コード ,a1.金額 FROM T_売上 AS a1 INNER JOIN T_受注 AS b1 ON b1.管理No = a1.管理No AND b1.受注区分 IN ('2','3') AND NOT (b1.得意先コード = '1' AND LEFT(b1.受注番号,1) ~ '^[0-9]+$') WHERE a1.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT b2.得意先コード ,a2.金額 FROM T_売上 AS a2 INNER JOIN T_受注 AS b2 ON b2.管理No = a2.管理No LEFT OUTER JOIN M_得意先 AS c2 ON c2.得意先コード = b2.得意先コード LEFT OUTER JOIN T_工号生産納入指示 AS d2 ON d2.発行連番 = b2.注文バーコード番号 WHERE a2.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND b2.受注区分 IN ('2','3') AND b2.得意先コード = '1' AND LEFT(b2.受注番号,1) ~ '^[0-9]+$' AND ((b2.納期 >= '2018-01-01' AND COALESCE(d2.次工程先コード,'') <> '') OR b2.納期 <= '2017-12-31') UNION ALL SELECT b3.得意先コード ,a3.金額 FROM T_売上 AS a3 INNER JOIN T_受注 AS b3 ON b3.管理No = a3.管理No AND b3.受注区分 IN ('2','3') AND b3.得意先コード = '1' AND LEFT(b3.受注番号,1) ~ '^[0-9]+$' AND b3.納期 >= '2018-01-01' LEFT OUTER JOIN T_工号生産納入指示 AS c3 ON c3.発行連番 = b3.注文バーコード番号 WHERE a3.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND COALESCE(c3.次工程先コード,'') = '' UNION ALL SELECT a4.得意先コード ,- a4.金額 AS 金額 FROM T_売上返品 AS a4 LEFT OUTER JOIN M_部品 AS b4 ON b4.品番 = a4.品番 WHERE a4.返品日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT a5.取引先コード AS 得意先コード ,a5.金額 FROM T_売上任意 AS a5 WHERE a5.売上日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) AND a5.取引先区分 = '1' ) AS A GROUP BY A.得意先コード ) AS x LEFT OUTER JOIN M_得意先 AS y ON y.得意先コード = x.得意先コード
-- SQL_REPORT_32_ORDERBY
ORDER BY COALESCE(y.表示順,0), x.得意先コード
-- SQL_REPORT_33_SELECT_TEMPLATE
SELECT x.請求元 ,CAST(COUNT(x.請求元) AS INT) AS 件数 ,SUM(x.金額) AS 売上金額 ,SUM(x.箱数) AS 箱数 ,SUM(x.袋数) AS 袋数 %s %s
-- SQL_REPORT_33_COMMON
FROM ( SELECT b.請求元 ,a.金額 ,CASE WHEN a.梱包単位 = '1' THEN COALESCE(e.梱包数,0) ELSE 0 END AS 箱数 ,CASE WHEN a.梱包単位 = '1' THEN 0 ELSE COALESCE(e.梱包数,0) END AS 袋数 FROM T_売上 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No AND b.得意先コード = '1' AND b.受注区分 IN ('2','3') LEFT OUTER JOIN ( SELECT 管理No ,分納No ,SUM(梱包数) AS 梱包数 FROM T_売上詳細 GROUP BY 管理No, 分納No ) AS e ON e.管理No = a.管理No AND e.分納No = a.分納No WHERE a.納入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS x WHERE x.請求元 <> '' GROUP BY x.請求元
-- SQL_REPORT_33_ORDERBY
ORDER BY x.請求元
-- SQL_REPORT_41_SELECT_TEMPLATE
SELECT CASE A.区分 WHEN '1' THEN '加工' WHEN '2' THEN '加工返' WHEN '3' THEN '材料' WHEN '4' THEN '材料返' ELSE '売上' END AS 区分 ,A.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,A.受注番号,A.枝番,A.品番,A.設変番号,A.品名,A.日付 ,A.数量重量,A.単価,A.仕入金額,CASE A.受入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,COALESCE(C.作業区略称,'') AS 材料仕入先名 FROM ( SELECT 1 AS 区分 ,c1.作業区コード,b1.受注番号,b1.枝番,b1.品番,b1.設変番号,b1.品名,a1.受入日 AS 日付 ,a1.受入数 AS 数量重量,a1.単価,a1.金額 AS 仕入金額,a1.受入形態区分,'' AS 材料仕入先コード FROM T_工程受入 AS a1 INNER JOIN T_受注 AS b1 ON b1.管理No = a1.管理No INNER JOIN T_発注 AS c1 ON c1.伝票番号 = a1.伝票番号 WHERE c1.作業区コード = ? AND a1.受入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT 2 AS 区分 ,a2.作業区コード,b2.受注番号,b2.枝番,b2.品番,b2.設変番号,b2.品名,a2.返品日 AS 日付 ,a2.数量 AS 数量重量,a2.単価,- a2.金額 AS 仕入金額,'' AS 受入形態区分,'' AS 材料仕入先コード FROM T_受入返品 AS a2 INNER JOIN T_受注 AS b2 ON b2.管理No = a2.管理No WHERE a2.作業区コード = ? AND a2.返品日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT CASE WHEN a3.取引分類 = '1' THEN CASE WHEN a3.取引区分 = '1' THEN 3 ELSE 4 END ELSE CASE WHEN a3.取引区分 = '1' THEN 1 ELSE 2 END END AS 区分 ,a3.仕入先コード AS 作業区コード ,'' AS 受注番号 ,'' AS 枝番 ,CASE WHEN a3.取引分類 = '1' THEN a3.材質名 ELSE a3.品番 END AS 品番 ,CASE WHEN a3.取引分類 = '1' THEN '' ELSE a3.設変番号 END AS 設変番号 ,CASE WHEN a3.取引分類 = '1' THEN a3.形状 ELSE a3.品名 END AS 品名 ,a3.取引日 AS 日付 ,CASE WHEN a3.取引分類 = '1' THEN a3.重量 ELSE a3.数量 END AS 数量重量 ,a3.単価 ,CASE WHEN a3.取引区分 = '1' THEN a3.金額 ELSE - a3.金額 END AS 仕入金額 ,'' AS 受入形態区分 ,CASE WHEN a3.取引分類 = '1' THEN a3.支給先コード ELSE NULL END AS 材料仕入先コード FROM T_仕入 AS a3 WHERE a3.仕入先コード = ? AND a3.取引日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT CASE WHEN a4.取引区分 = '1' THEN 3 ELSE 4 END AS 区分 ,a4.支給先コード AS 作業区コード ,'' AS 受注番号 ,'' AS 枝番 ,a4.材質名 AS 品番 ,'' AS 設変番号 ,a4.形状 AS 品名 ,a4.取引日 AS 日付 ,CASE WHEN a4.取引区分 = '1' AND a4.相殺方法 = '2' THEN c4.重量 ELSE a4.重量 END AS 数量重量 ,a4.単価 ,CASE WHEN a4.取引区分 = '1' AND a4.相殺方法 = '1' THEN - a4.支給金額 WHEN a4.取引区分 = '1' AND a4.相殺方法 = '2' THEN - c4.相殺金額 ELSE a4.支給金額 END AS 仕入金額 ,'' AS 受入形態区分 ,a4.仕入先コード AS 材料仕入先コード FROM T_仕入 AS a4 LEFT OUTER JOIN T_仕入相殺 AS c4 ON c4.SeqNo = a4.SeqNo WHERE a4.取引分類 = '1' AND a4.支給先コード = ? AND CASE WHEN a4.取引区分 = '1' AND a4.相殺方法 = '2' THEN c4.相殺日 ELSE a4.取引日 + interval'1 month' END BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT 5 AS 区分 ,a5.取引先コード AS 作業区コード ,'' AS 受注番号,'' AS 枝番,a5.品番,a5.設変番号,a5.品名,a5.売上日 AS 日付 ,a5.数量 AS 数量重量,a5.単価,- a5.金額 AS 仕入金額,'' AS 受入形態区分,'' AS 材料仕入先コード FROM T_売上任意 AS a5 WHERE a5.取引先区分 = '2' AND a5.取引先コード = ? AND a5.売上日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS A LEFT OUTER JOIN M_作業区仕入先 AS B ON B.作業区コード = A.作業区コード LEFT OUTER JOIN M_作業区仕入先 AS C ON C.作業区コード = A.材料仕入先コード ORDER BY A.日付, A.区分, A.品番, A.設変番号
-- SQL_REPORT_42_SELECT_TEMPLATE
SELECT CASE WHEN B.分類 = '1' THEN CASE WHEN B.作業区分類 = '1' THEN '自社' ELSE '協力会社' END ELSE '材料仕入先' END AS 分類 ,A.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,A.件数 ,A.仕入金額 %s %s
-- SQL_REPORT_42_COUNT_TEMPLATE
SELECT CAST(COUNT(A.作業区コード) AS INT) %s %s
-- SQL_REPORT_42_COMMON
FROM ( SELECT x.作業区コード ,CAST(COUNT(x.作業区コード) AS INT) AS 件数 ,SUM(x.仕入金額) AS 仕入金額 FROM ( SELECT b1.作業区コード ,a1.金額 AS 仕入金額 FROM T_工程受入 AS a1 INNER JOIN T_発注 AS b1 ON b1.伝票番号 = a1.伝票番号 WHERE a1.受入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT a2.作業区コード ,- a2.金額 AS 仕入金額 FROM T_受入返品 AS a2 WHERE a2.返品日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT a3.仕入先コード AS 作業区コード ,CASE WHEN a3.取引区分 = '1' THEN a3.金額 ELSE - a3.金額 END AS 仕入金額 FROM T_仕入 AS a3 WHERE a3.取引日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT a4.支給先コード AS 作業区コード ,CASE WHEN a4.取引区分 = '1' AND a4.相殺方法 = '1' THEN - a4.支給金額 WHEN a4.取引区分 = '1' AND a4.相殺方法 = '2' THEN - c4.相殺金額 ELSE a4.支給金額 END AS 仕入金額 FROM T_仕入 AS a4 LEFT OUTER JOIN T_仕入相殺 AS c4 ON c4.SeqNo = a4.SeqNo WHERE a4.取引分類 = '1' AND CASE WHEN a4.取引区分 = '1' AND a4.相殺方法 = '2' THEN c4.相殺日 ELSE a4.取引日 + interval'1 month' END BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT a5.取引先コード AS 作業区コード ,- a5.金額 AS 仕入金額 FROM T_売上任意 AS a5 WHERE a5.取引先区分 = '2' AND a5.売上日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS x GROUP BY x.作業区コード ) AS A LEFT OUTER JOIN M_作業区仕入先 AS B ON B.作業区コード = A.作業区コード
-- SQL_REPORT_42_ORDERBY
ORDER BY COALESCE(B.表示順,0), B.作業区コード
-- SQL_REPORT_61_COUNT_TEMPLATE
SELECT CAST(COUNT(c.得意先コード) AS INT) %s %s %s
-- SQL_REPORT_61_SELECT_TEMPLATE
SELECT COALESCE(c.得意先コード,'') AS 得意先コード ,COALESCE(d.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,a.品名 ,a.在庫数 ,a.仮受在庫数 ,a.出荷依頼数 ,a.在庫数 - a.出荷依頼数 AS 有効在庫数 ,COALESCE(c.単価,0) AS 単価 ,CAST(TRUNC(COALESCE(c.単価,0) * a.在庫数,0) as BIGINT) AS 在庫金額 ,CASE WHEN a.棚番2 = '' THEN a.棚番1 ELSE a.棚番1 || '-' || a.棚番2 END AS 棚番 ,CASE WHEN a.補正入数 <> 0 THEN a.補正入数 ELSE COALESCE(e.実績入数,0) END AS 入数 ,CASE WHEN a.補正入数 <> 0 THEN CEIL(a.在庫数 / a.補正入数) WHEN COALESCE(e.実績入数,0) <> 0 THEN CEIL(a.在庫数 / e.実績入数) ELSE 0 END AS 箱数 %s %s %s
-- SQL_REPORT_61_COMMON
FROM M_在庫 AS a LEFT OUTER JOIN ( SELECT x.品番, x.設変番号, x.単価, CASE WHEN LEFT(x.得意先コード,2) = '00' THEN RIGHT(x.得意先コード,1) WHEN LEFT(x.得意先コード,1) = '0' THEN RIGHT(x.得意先コード,2) ELSE x.得意先コード END AS 得意先コード FROM ( SELECT 品番, 設変番号, MIN(単価) AS 単価, MIN(RIGHT('000' || 得意先コード, 3)) AS 得意先コード FROM T_受注 WHERE 単価 <> 0 GROUP BY 品番, 設変番号 ) AS x ) AS c ON c.品番 = a.品番 AND c.設変番号 = a.設変番号 LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = c.得意先コード LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(x.納入日) AS 納入日, MAX(COALESCE(z.個数,0)) AS 実績入数 FROM T_売上 AS x LEFT OUTER JOIN T_売上詳細 AS z ON z.管理No = x.管理No INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS e ON e.品番 = a.品番 AND e.設変番号 = a.設変番号 WHERE COALESCE(e.納入日,'9999-12-31') <= CURRENT_DATE - CAST(? || ' month' AS INTERVAL)
-- SQL_REPORT_61_WHERE_TOKUISAKI
AND COALESCE(c.得意先コード,'') = ?
-- SQL_REPORT_61_ORDERBY
ORDER BY COALESCE(d.表示順,0), COALESCE(c.得意先コード,''), a.品番, a.設変番号
-- SQL_REPORT_COUNT
SELECT CAST(COUNT(a.管理No) AS INT)
-- SQL_REPORT_13_COUNT
SELECT CAST(COUNT(a.得意先コード) AS INT)
-- SQL_REPORT_14_COUNT
SELECT CAST(COUNT(x.得意先コード) AS INT)
-- SQL_REPORT_11_SELECT
SELECT a.管理No, a.得意先コード, COALESCE(b.得意先名,'') AS 得意先名, a.受注番号, a.枝番, a.品番, a.設変番号, a.品名, a.客先品番, a.受注日, a.納期, a.受注数, a.単価, CASE COALESCE(b.金額端数処理区分,'1') WHEN '1' THEN CAST(FLOOR(a.単価 * a.受注数) as BIGINT) WHEN '2' THEN CAST(CEIL(a.単価 * a.受注数) as BIGINT) ELSE CAST(ROUND((a.単価 * a.受注数),0) as BIGINT) END AS 受注金額,a.請求元 ,a.納入場所名 ,a.次工程名
-- SQL_REPORT_12_SELECT
SELECT CASE WHEN a.納期 < CURRENT_DATE THEN '*' ELSE '' END AS 遅れ,a.得意先コード, COALESCE(b.得意先名,'') AS 得意先名, a.受注番号, a.枝番, a.品番, a.設変番号,a.品名, a.客先品番, a.受注日, a.納期, c.回答日, d.納入日 AS 出荷予定日, a.受注数, a.単価, CASE COALESCE(b.金額端数処理区分,'1') WHEN '1' THEN CAST(FLOOR(a.単価 * a.受注数) as BIGINT) WHEN '2' THEN CAST(CEIL(a.単価 * a.受注数) as BIGINT) ELSE CAST(ROUND((a.単価 * a.受注数),0) as BIGINT) END AS 受注金額,a.受注数 - COALESCE(e.完了数,0) AS 受注残数,CASE WHEN a.受注数 - COALESCE(e.完了数,0) > 0 THEN CASE COALESCE(b.金額端数処理区分,'1') WHEN '1' THEN CAST(FLOOR(a.単価 * (a.受注数 - COALESCE(e.完了数,0))) as BIGINT) WHEN '2' THEN CAST(CEIL(a.単価 * (a.受注数 - COALESCE(e.完了数,0))) as BIGINT) ELSE CAST(ROUND((a.単価 * (a.受注数 - COALESCE(e.完了数,0))),0) as BIGINT) END ELSE 0 END AS 受注残金額,a.請求元,a.管理No,a.納入場所名,a.次工程名,CASE WHEN COALESCE(f.補正入数,0) <> 0 THEN f.補正入数 ELSE COALESCE(g.実績入数,0) END AS 入数,CASE WHEN COALESCE(f.補正入数,0) <> 0 THEN CEIL((a.受注数 - COALESCE(e.完了数,0)) / f.補正入数) WHEN COALESCE(g.実績入数,0) <> 0 THEN CEIL((a.受注数 - COALESCE(e.完了数,0)) / g.実績入数) ELSE 0 END AS 箱数
-- SQL_REPORT_13_SELECT
SELECT A.得意先コード ,B.得意先名 ,A.受注残件数 ,A.受注残金額
-- SQL_REPORT_14_SELECT
SELECT COALESCE(y.得意先名,'') AS 得意先名,x.*
-- SQL_REPORT_11_CORE
FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード WHERE a.受注区分 IN ('2','3')
-- SQL_REPORT_12_CORE
FROM T_受注 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN ( SELECT 管理No, MAX(回答日) AS 回答日 FROM T_納期回答 GROUP BY 管理No) AS c ON c.管理No = a.管理No LEFT OUTER JOIN ( SELECT x.管理No, x.納入日 FROM T_検査出荷依頼 AS x WHERE x.検査結果区分 <> '2' AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = x.管理No AND 分納No = x.分納No)) AS d ON d.管理No = a.管理No LEFT OUTER JOIN ( SELECT 管理No,SUM(依頼数) AS 完了数 FROM T_売上 GROUP BY 管理No) AS e ON e.管理No = a.管理No LEFT OUTER JOIN M_在庫 AS f ON f.品番 = a.品番 AND f.設変番号 = a.設変番号 LEFT OUTER JOIN ( SELECT y.品番, y.設変番号, MAX(COALESCE(x.個数,0)) AS 実績入数 FROM T_売上詳細 AS x INNER JOIN T_受注 AS y ON y.管理No = x.管理No GROUP BY y.品番, y.設変番号 ) AS g ON g.品番 = a.品番 AND g.設変番号 = a.設変番号 WHERE a.受注区分 IN ('2','3') AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 納入形態区分 IN ('1','2','4'))
-- SQL_REPORT_13_CORE1
FROM ( SELECT x.得意先コード ,CAST(COUNT(x.得意先コード) AS INT) AS 受注残件数 ,CAST(SUM(x.受注残金額) AS BIGINT) AS 受注残金額 FROM ( SELECT a.得意先コード ,CASE WHEN a.受注数 - COALESCE(c.完了数,0) > 0 THEN CASE b.金額端数処理区分 WHEN '1' THEN CAST(FLOOR(a.単価 * (a.受注数 - COALESCE(c.完了数,0))) as BIGINT) WHEN '2' THEN CAST(CEIL(a.単価 * (a.受注数 - COALESCE(c.完了数,0))) as BIGINT) ELSE CAST(ROUND((a.単価 * (a.受注数 - COALESCE(c.完了数,0))),0) as BIGINT) END ELSE 0 END AS 受注残金額 FROM T_受注 AS a INNER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN ( SELECT 管理No ,SUM(依頼数) AS 完了数 FROM T_売上 GROUP BY 管理No ) AS c ON c.管理No = a.管理No WHERE a.受注区分 IN ('2','3') AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 納入形態区分 IN ('1','2','4'))
-- SQL_REPORT_13_CORE2
) AS x GROUP BY x.得意先コード ) AS A INNER JOIN M_得意先 AS B ON B.得意先コード = A.得意先コード
-- SQL_REPORT_14_CORE1
FROM (SELECT a.得意先コード,a.受注番号,a.枝番,a.品番,a.設変番号,a.品名,a.受注日,a.受注数,a.単価 AS 受注単価,b.加工費 + b.材料費 AS 原価,CASE WHEN a.単価 <> 0 THEN CAST(TRUNC((b.加工費 + b.材料費) / a.単価 * 100,0) as BIGINT) ELSE 0 END AS 原価率,CAST(TRUNC(a.単価 * a.受注数,0) as BIGINT) AS 受注金額 FROM T_受注 AS a INNER JOIN ( SELECT 管理No ,SUM(加工費) AS 加工費 ,SUM(材料費) AS 材料費 FROM T_生産計画詳細 GROUP BY 管理No ) AS b ON b.管理No = a.管理No WHERE a.受注区分 <> '2'
-- SQL_REPORT_14_CORE2
) AS x LEFT OUTER JOIN M_得意先 AS y ON y.得意先コード = x.得意先コード
-- SQL_REPORT_TOKUISAKI
AND a.得意先コード = ?
-- SQL_REPORT_ZYUCHUUBI
AND a.受注日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
-- SQL_REPORT_NOUKI
AND a.納期 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
-- SQL_REPORT_HINBAN
AND a.品番 &^ ?
-- SQL_REPORT_GENKARITSU
WHERE x.原価率 BETWEEN CAST(CASE WHEN ? = '' THEN '0' ELSE ? END as INT) AND CAST(CASE WHEN ? = '' THEN '100' ELSE ? END as INT)
-- SQL_REPORT_12_CHUUBAN_ALPHABET
AND LEFT(a.受注番号,1) !~ '^[0-9]+$'
-- SQL_REPORT_12_CHUUBAN_SUUJI
AND LEFT(a.受注番号,1) ~ '^[0-9]+$'
-- SQL_REPORT_11_ORDER_BY
ORDER BY COALESCE(b.表示順,0), a.得意先コード, a.品番, a.受注日
-- SQL_REPORT_12_ORDER_BY
ORDER BY COALESCE(b.表示順,0), a.得意先コード, a.納期, a.品番, a.設変番号
-- SQL_REPORT_13_ORDER_BY
ORDER BY A.受注残金額 DESC, B.表示順, A.得意先コード
-- SQL_REPORT_14_ORDER_BY
ORDER BY COALESCE(y.表示順,0), x.得意先コード, x.品番, x.受注日
-- SQL_REPORT_51_SELECT_TEMPLATE
SELECT a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.通知日 ,CASE a.図面種類 WHEN '1' THEN '図面配布' ELSE '設変通知' END AS 図面種類 ,CASE a.図面種類 WHEN '1' THEN '' ELSE a.新設変番号 END AS 新設変番号 ,CASE a.作業指示区分 WHEN '1' THEN '工程変更' WHEN '2' THEN '製造中止' ELSE '' END AS 作業指示 ,CASE a.仕掛品対処区分 WHEN '1' THEN '使用可' WHEN '2' THEN '修正' WHEN '3' THEN '使用不可' ELSE '' END AS 仕掛品対処 ,COALESCE(d.作業区コード,'') AS 作業区コード ,COALESCE(e.作業区名,'') AS 作業区名 ,a.発行日 ,d.返却日 %s %s %s
-- SQL_REPORT_51_COUNT_TEMPLATE
SELECT CAST(COUNT(a.得意先コード) AS INT) %s %s %s
-- SQL_REPORT_51_COMMON
FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN T_図面詳細 AS d ON d.SeqNo = a.SeqNo LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード WHERE a.得意先コード = ? AND a.通知日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
-- SQL_REPORT_51_WHERE_HINBAN
AND a.品番 &^ ?
-- SQL_REPORT_51_ORDERBY
ORDER BY a.品番, a.設変番号, a.通知日, COALESCE(d.工程順序No,0)
-- SQL_REPORT_71_SELECT_TEMPLATE
SELECT a.品番 ,a.設変番号 ,COALESCE(b.品名,'') AS 品名 ,a.材質コード ,COALESCE(c.材質名,'') AS 材質名 ,a.材料形状コード ,COALESCE(d.材料形状名,'') AS 材料形状名 ,a.材料径 ,a.材料長 ,a.製品長 ,a.残材長 ,a.入力方法 ,a.材質ベース単価 ,a.材料重量 ,a.材料単価 ,a.取数 ,a.材料費 ,a.製品材料重量 ,a.製品重量 ,a.くず回収率 ,a.くず単価 ,a.くず金額 ,a.正味材料費 ,a.材料費補正額 ,a.登録日 %s %s %s
-- SQL_REPORT_71_COUNT_TEMPLATE
SELECT CAST(COUNT(a.品番) AS INT) %s %s %s
-- SQL_REPORT_71_COMMON
FROM T_材料計算 AS a LEFT OUTER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS d ON d.材料形状コード = a.材料形状コード
-- SQL_REPORT_71_WHERE_HINBAN
WHERE a.品番 &^ ?
-- SQL_REPORT_71_ORDERBY
ORDER BY a.品番, a.設変番号
-- SQL_REPORT_43_SELECT
SELECT CASE A.区分 WHEN '1' THEN '材料' ELSE '材料返' END AS 区分 ,A.作業区コード ,COALESCE(B.作業区名,'') AS 作業区名 ,A.材質名 ,A.形状 ,A.日付 ,A.重量 ,A.材料単位 ,A.単価 ,A.仕入金額 ,COALESCE(C.作業区略称,'') AS 材料仕入先名 ,A.備考 FROM ( SELECT CASE WHEN a.取引区分 = '1' THEN 1 ELSE 2 END AS 区分 ,a.仕入先コード AS 作業区コード ,a.材質名 ,a.形状 ,a.取引日 AS 日付 ,a.重量 ,CASE WHEN a.材料単位 = '1' THEN 'kg' ELSE '本' END AS 材料単位 ,a.単価 ,CASE WHEN a.取引区分 = '1' THEN a.金額 ELSE - a.金額 END AS 仕入金額 ,a.支給先コード AS 材料仕入先コード ,a.備考 FROM T_仕入 AS a WHERE a.取引分類 = '1' AND a.仕入先コード = ? AND a.取引日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) UNION ALL SELECT CASE WHEN b.取引区分 = '1' THEN 1 ELSE 2 END AS 区分 ,b.支給先コード AS 作業区コード ,b.材質名 ,b.形状 ,b.取引日 AS 日付 ,CASE WHEN b.取引区分 = '1' AND b.相殺方法 = '2' THEN c.重量 ELSE b.重量 END AS 数量重量 ,CASE WHEN b.材料単位 = '1' THEN 'kg' ELSE '本' END AS 材料単位 ,b.単価 ,CASE WHEN b.取引区分 = '1' AND b.相殺方法 = '1' THEN - b.支給金額 WHEN b.取引区分 = '1' AND b.相殺方法 = '2' THEN - c.相殺金額 ELSE b.支給金額 END AS 仕入金額 ,b.仕入先コード AS 材料仕入先コード ,b.備考 FROM T_仕入 AS b LEFT OUTER JOIN T_仕入相殺 AS c ON c.SeqNo = b.SeqNo WHERE b.取引分類 = '1' AND b.支給先コード = ? AND CASE WHEN b.取引区分 = '1' AND b.相殺方法 = '2' THEN c.相殺日 ELSE b.取引日 + interval'1 month' END BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS A LEFT OUTER JOIN M_作業区仕入先 AS B ON B.作業区コード = A.作業区コード LEFT OUTER JOIN M_作業区仕入先 AS C ON C.作業区コード = A.材料仕入先コード ORDER BY A.日付, A.区分, A.材質名, A.形状
-- SQL_REPORT_64_SELECT_TEMPLATE
SELECT * FROM ( SELECT DISTINCT c.品番 ,c.設変番号 ,c.品名 ,COALESCE(d.在庫数,0) AS 在庫数 ,CASE WHEN d.棚番1 IS NULL THEN '' ELSE CASE WHEN d.棚番2 = '' THEN d.棚番1 ELSE d.棚番1 || '-' || d.棚番2 END END AS 棚番 ,c.受注番号 ,c.枝番 ,a.受入数 AS 支給数 ,a.受入日 AS 支給日 ,CASE WHEN c.受注区分 IN ('1','4') THEN CASE WHEN f.管理No IS NULL THEN '' ELSE CASE WHEN f.検査区分 = false THEN CASE f.納入形態区分 WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '' END ELSE CASE f.検査結果区分 WHEN '0' THEN '依頼中' WHEN '1' THEN CASE f.納入形態区分 WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '' END WHEN '2' THEN '不合格' ELSE '' END END END ELSE CASE WHEN f.管理No IS NULL THEN '' ELSE CASE WHEN f.検査結果区分 = '2' THEN '不合格' ELSE CASE WHEN g.管理No IS NULL THEN '依頼中' ELSE CASE g.納入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' ELSE '' END END END END END AS 状況 ,CASE WHEN c.受注区分 IN ('1','4') THEN CASE WHEN f.管理No IS NULL THEN NULL ELSE CASE WHEN f.検査区分 = false THEN NULL ELSE CASE f.検査結果区分 WHEN '0' THEN f.依頼日 ELSE NULL END END END ELSE CASE WHEN f.管理No IS NULL THEN NULL ELSE CASE WHEN f.検査結果区分 = '2' THEN NULL ELSE CASE WHEN g.管理No IS NULL THEN f.依頼日 ELSE NULL END END END END AS 依頼日 ,COALESCE(h.工程順序No, 0) AS 工程No ,COALESCE(i.作業区略称,'') AS 作業区名 ,COALESCE(j.受入数,0) AS 受入数 FROM T_工程受入 AS a INNER JOIN T_生産計画詳細 AS b ON b.管理No = a.管理No AND b.工程順序No = a.工程順序No AND b.作業区コード = '448' AND b.工程コード = '50' INNER JOIN T_受注 AS c ON c.管理No = a.管理No LEFT OUTER JOIN ( SELECT 品番 ,設変番号 ,在庫数 ,CASE 棚番1 WHEN '0' THEN '' WHEN '00' THEN '' ELSE 棚番1 END AS 棚番1 ,CASE 棚番2 WHEN '0' THEN '' WHEN '00' THEN '' ELSE 棚番2 END AS 棚番2 FROM M_在庫 ) AS d ON d.品番 = c.品番 AND d.設変番号 = c.設変番号 LEFT OUTER JOIN ( SELECT 管理No, MAX(分納No) AS 分納No FROM T_検査出荷依頼 GROUP BY 管理No ) AS e ON e.管理No = a.管理No LEFT OUTER JOIN T_検査出荷依頼 AS f ON f.管理No = e.管理No AND f.分納No = e.分納No LEFT OUTER JOIN T_売上 AS g ON g.管理No = f.管理No AND g.分納No = f.分納No LEFT OUTER JOIN T_発注 AS h ON h.管理No = a.管理No AND h.工程順序No <> a.工程順序No AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = h.管理No AND 工程順序No = h.工程順序No AND 受入形態区分 IN ('1','2')) LEFT OUTER JOIN M_作業区仕入先 AS i ON i.作業区コード = h.作業区コード LEFT OUTER JOIN ( SELECT 管理No ,工程順序No ,SUM(受入数) AS 受入数 FROM T_工程受入 GROUP BY 管理No, 工程順序No ) AS j ON j.管理No = h.管理No AND j.工程順序No = h.工程順序No WHERE a.受入日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE) ) AS A WHERE A.在庫数 <> 0 OR A.状況 IN ('','ING','依頼中','分納') ORDER BY A.品番, A.設変番号, A.支給日, A.受注番号, A.枝番, A.工程No
-- SQL_REPORT_24_COUNT_TEMPLATE
SELECT CAST(COUNT(a.作業区コード) AS INT) %s %s %s
-- SQL_REPORT_24_SELECT_TEMPLATE
SELECT a.作業区コード ,COALESCE(b.作業区名,'') AS 作業区名 ,a.工程コード ,COALESCE(c.工程略称,'') AS 工程名 ,d.受注番号 ,d.枝番 ,d.品番 ,d.設変番号 ,d.品名 ,a.発注日 ,a.納期 ,CASE WHEN f.回答日 IS NOT NULL THEN CAST(DATE_PART('YEAR',f.回答日) as VARCHAR) || '/' || CAST(DATE_PART('MONTH',f.回答日) as VARCHAR) || '/' || CAST(DATE_PART('DAY',f.回答日) as VARCHAR) ELSE '' END AS 回答日 ,COALESCE(f.希望納入数,0) AS 回答数 ,a.発注数 ,CASE COALESCE(h.受入形態区分,'') WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' ELSE '' END AS 受入形態 ,COALESCE(g.受入数,0) AS 受入数 ,a.単価 ,CAST(TRUNC(a.単価 * a.発注数,0) as BIGINT) AS 発注金額 ,d.単価 AS 売値 ,CASE COALESCE(k.金額端数処理区分,'1') WHEN '1' THEN CAST(FLOOR(d.単価 * d.受注数) as BIGINT) WHEN '2' THEN CAST(CEIL(d.単価 * d.受注数) as BIGINT) ELSE CAST(ROUND((d.単価 * d.受注数),0) as BIGINT) END AS 売値金額 ,COALESCE(i.作業区コード,'') AS 次工程コード ,CASE WHEN i.作業区コード IS NULL THEN '古河（本社）' ELSE COALESCE(j.作業区名,'') END AS 次工程名 %s %s %s %s
-- SQL_REPORT_24_COMMON
FROM T_発注 AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS c ON c.工程コード = a.工程コード INNER JOIN T_受注 AS d ON d.管理No = a.管理No LEFT OUTER JOIN M_得意先 AS k ON k.得意先コード = d.得意先コード LEFT OUTER JOIN ( SELECT 管理No ,工程順序No ,MIN(分納No) AS 分納No FROM T_納期回答依頼 WHERE 回答日 IS NOT NULL GROUP BY 管理No, 工程順序No ) AS e ON e.管理No = a.管理No AND e.工程順序No = a.工程順序No LEFT OUTER JOIN T_納期回答依頼 AS f ON f.管理No = e.管理No AND f.工程順序No = e.工程順序No AND f.分納No = e.分納No LEFT OUTER JOIN ( SELECT 伝票番号 ,MAX(分納No) AS 分納No ,SUM(受入数) AS 受入数 FROM T_工程受入 GROUP BY 伝票番号 ) AS g ON g.伝票番号 = a.伝票番号 LEFT OUTER JOIN T_工程受入 AS h ON h.伝票番号 = g.伝票番号 AND h.分納No = g.分納No LEFT OUTER JOIN T_生産計画詳細 AS i ON i.管理No = a.管理No AND i.工程順序No = (a.工程順序No + 1) LEFT OUTER JOIN M_作業区仕入先 AS j ON j.作業区コード = i.作業区コード WHERE a.発注日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)
-- SQL_REPORT_24_WHERE_SAGYOUKU
AND a.作業区コード = ?
-- SQL_REPORT_24_WHERE_HINBANI
AND d.品番 &^ ?
-- SQL_REPORT_24_ORDERBY
ORDER BY a.作業区コード, d.品番, a.発注日, a.納期
-- SQL_REPORT_25_COUNT_TEMPLATE
SELECT CAST(COUNT(作業区コード) AS INT) %s %s %s
-- SQL_REPORT_25_SELECT_TEMPLATE
SELECT 作業区コード ,作業区 ,受注番号 ,枝番 ,品番 ,設変番号 ,発注日 ,納期 ,発注数 ,発注数 - 総受入数 AS 発注残数 ,回答数 ,CASE WHEN 回答日 IS NOT NULL THEN TO_CHAR(回答日, 'YYYY/FMMM/FMDD') ELSE '' END AS 回答日 ,得意先略称 ,CASE WHEN 受注有無 THEN '有' ELSE '無' END AS 受注引当 ,CASE WHEN 補正入数 <> 0 THEN 補正入数 ELSE 実績入数 END AS 入数/箱 ,CASE WHEN 補正入数 <> 0 THEN CEIL(回答数 / 補正入数) WHEN 実績入数 <> 0 THEN CEIL(回答数 / 実績入数) ELSE 0 END AS 箱数 %s %s %s %s
-- SQL_REPORT_25_COMMON
FROM ( SELECT a.作業区コード ,COALESCE(f.作業区名, '') AS 作業区 ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,a.発注日 ,a.納期 ,a.発注数 ,COALESCE(( SELECT SUM(受入数) FROM T_工程受入 WHERE 伝票番号 = a.伝票番号 GROUP BY 伝票番号 ), 0) AS 総受入数 ,COALESCE(c.希望納入数, 0) AS 回答数 ,c.回答日 ,g.得意先略称 ,EXISTS( SELECT * FROM T_受注 AS ia WHERE ia.品番 = b.品番 AND 受注区分 IN ('2', '3') AND NOT EXISTS ( SELECT * FROM T_売上 AS ib WHERE ib.管理No = ia.管理No AND ib.納入形態区分 IN ('1', '2', '4') ) ) AS 受注有無 ,COALESCE(d.補正入数, 0) AS 補正入数 ,COALESCE(e.実績入数, 0) AS 実績入数 FROM ( SELECT * FROM T_発注 AS aa WHERE aa.最終工程区分 = true AND NOT EXISTS ( SELECT * FROM T_工程受入 AS ab WHERE aa.伝票番号 = ab.伝票番号 AND ab.受入形態区分 IN ('1', '2') ) ) AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN T_納期回答依頼 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No AND c.回答日 IS NOT NULL LEFT OUTER JOIN ( SELECT da.品番 ,da.補正入数 FROM M_在庫 AS da INNER JOIN ( SELECT 品番 ,MAX(設変番号) AS 設変番号 FROM M_在庫 GROUP BY 品番 ) AS db ON db.品番 = da.品番 AND db.設変番号 = da.設変番号 ) AS d ON d.品番 = b.品番 LEFT OUTER JOIN ( SELECT ec.品番 ,MAX(eb.個数) AS 実績入数 FROM T_売上 AS ea LEFT OUTER JOIN T_売上詳細 AS eb ON eb.管理No = ea.管理No INNER JOIN T_受注 AS ec ON ec.管理No = ea.管理No INNER JOIN ( SELECT edc.品番 ,MAX(edc.設変番号) AS 設変番号 FROM T_売上 AS eda LEFT OUTER JOIN T_売上詳細 AS edb ON edb.管理No = eda.管理No INNER JOIN T_受注 AS edc ON edc.管理No = eda.管理No GROUP BY edc.品番 ) AS ed ON ed.品番 = ec.品番 AND ed.設変番号 = ec.設変番号 GROUP BY ec.品番, ec.設変番号 ) AS e ON e.品番 = b.品番 LEFT OUTER JOIN M_作業区仕入先 AS f ON f.作業区コード = a.作業区コード LEFT OUTER JOIN M_得意先 AS g ON g.得意先コード = b.得意先コード) AS h
-- SQL_REPORT_25_WHERE_SAGYOUKU
WHERE 作業区コード = ?
-- SQL_REPORT_25_WHERE_KAITOUBI
回答日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END AS DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END AS DATE)
-- SQL_REPORT_25_ORDERBY
ORDER BY 納期, 回答日
-- SQL_REPORT_44_COUNT_TEMPLATE
SELECT CAST(COUNT(a.作業区コード) AS INT) %s %s %s
-- SQL_REPORT_44_SELECT_TEMPLATE
SELECT a.作業区コード AS 支給先コード ,COALESCE(b.作業区名, '') AS 支給先 ,a.年月 ,a.件数 ,a.金額 ,a.消費税 %s %s %s
-- SQL_REPORT_44_COMMON
FROM ( SELECT c.作業区コード ,c.年月 ,CAST(COUNT(c.作業区コード) as BIGINT) AS 件数 ,CAST(SUM(c.金額) as BIGINT) AS 金額 ,CAST(ROUND((SUM(c.金額)*0.1),0) as BIGINT) AS 消費税 FROM ( SELECT d.支給先コード AS 作業区コード ,CASE WHEN d.取引区分 = '1' AND d.相殺方法 = '2' THEN TO_CHAR(e.相殺日,'YYYY/MM') ELSE TO_CHAR(d.取引日 +interval '1 month' ,'YYYY/MM') END AS 年月 ,CASE WHEN d.取引区分 = '1' AND d.相殺方法 = '1' THEN d.支給金額 WHEN d.取引区分 = '1' AND d.相殺方法 = '2' THEN e.相殺金額 ELSE - d.支給金額 END AS 金額 FROM T_仕入 d LEFT OUTER JOIN T_仕入相殺 AS e ON e.SeqNo = d.SeqNo WHERE d.取引分類 = '1' AND CASE WHEN d.取引区分 = '1' AND d.相殺方法 = '2' THEN e.相殺日 ELSE d.取引日 + interval'1 month' END BETWEEN CAST(? as DATE) AND (CAST(? as DATE) + interval '1 month' ) - interval '1 day' UNION ALL SELECT f.取引先コード AS 作業区コード ,TO_CHAR(f.売上日,'YYYY/MM') AS 年月 ,f.金額 FROM T_売上任意 AS f WHERE f.取引先区分 = '2' AND f.売上日 BETWEEN CAST(? as DATE) AND (CAST(? as DATE) + interval '1 month' ) - interval '1 day' ) AS c GROUP BY c.作業区コード, c.年月 ) AS a LEFT OUTER JOIN M_作業区仕入先 AS b ON b.作業区コード = a.作業区コード WHERE b.検収書発行区分 = true
-- SQL_REPORT_44_WHERE_SAGYOUKU
AND a.作業区コード = ?
-- SQL_REPORT_44_ORDERBY
ORDER BY a.作業区コード, a.年月

