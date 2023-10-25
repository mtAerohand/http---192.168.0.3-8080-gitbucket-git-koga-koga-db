-- SQL_GET_ALL
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.受注日 ,a.納期 ,CASE a.受注区分 WHEN '1' THEN '1' /* 先行手配 */ WHEN '2' THEN '0' /* 受注（計画無し） */ WHEN '3' THEN '1' /* 受注（計画有り） */ ELSE '1' /* 再納 */ END AS 生産数表示 ,COALESCE(b.生産数,0) AS 生産数 ,CASE a.受注区分 WHEN '1' THEN '0' /* 先行手配 */ WHEN '2' THEN '1' /* 受注（計画無し） */ WHEN '3' THEN '1' /* 受注（計画有り） */ ELSE '0' /* 再納 */ END AS 受注数表示 ,a.受注数 ,CASE WHEN a.受注区分 IN ('1','4') /* 先行手配, 再納 */ THEN CASE WHEN d.管理No IS NULL /* 依頼無し */ THEN '' /* 依頼有り */ ELSE CASE WHEN d.検査区分 = false /* 検査無し */ THEN CASE d.納入形態区分 WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '??' END /* 検査有り */ ELSE CASE d.検査結果区分 /* 未検査 */ WHEN '0' THEN '依頼中' /* 合格 */ WHEN '1' THEN CASE d.納入形態区分 WHEN '11' THEN 'END' WHEN '12' THEN 'STP' WHEN '13' THEN 'ING' ELSE '' END /* 不合格 */ WHEN '2' THEN '不合格' ELSE '??' END END END /* 受注（計画無し）,受注（計画有り）,再納 */ ELSE CASE WHEN d.管理No IS NULL /* 依頼無し */ THEN '' /* 依頼有り */ ELSE CASE WHEN d.検査結果区分 = '2' /* 不合格 */ THEN '不合格' /* 不合格以外 */ ELSE CASE WHEN e.管理No IS NULL /* 売上無し */ THEN '依頼中' /* 売上有り */ ELSE CASE e.納入形態区分 WHEN '1' THEN '完納' WHEN '2' THEN '打切り' WHEN '3' THEN '分納' WHEN '4' THEN '過剰納入' ELSE '??' END END END END END AS 状況 ,CASE WHEN a.受注区分 IN ('1','4') /* 先行手配, 再納 */ THEN CASE WHEN d.管理No IS NULL /* 依頼無し */ THEN NULL /* 依頼有り */ ELSE CASE WHEN d.検査区分 = false /* 検査無し */ THEN CASE d.納入形態区分 WHEN '11' THEN d.依頼日 WHEN '12' THEN d.依頼日 WHEN '13' THEN NULL ELSE NULL END /* 検査有り */ ELSE CASE d.検査結果区分 /* 未検査 */ WHEN '0' THEN NULL /* 合格 */ WHEN '1' THEN CASE d.納入形態区分 WHEN '11' THEN d.結果登録日 WHEN '12' THEN d.結果登録日 WHEN '13' THEN NULL ELSE NULL END /* 不合格 */ WHEN '2' THEN d.結果登録日 ELSE NULL END END END /* 受注（計画無し）,受注（計画有り）,再納 */ ELSE CASE WHEN d.管理No IS NULL /* 依頼無し */ THEN NULL /* 依頼有り */ ELSE CASE WHEN d.検査結果区分 = '2' /* 不合格 */ THEN d.結果登録日 /* 不合格以外 */ ELSE CASE WHEN e.管理No IS NULL /* 売上無し */ THEN NULL /* 売上有り */ ELSE CASE e.納入形態区分 WHEN '1' THEN e.納入日 WHEN '2' THEN e.納入日 WHEN '3' THEN NULL WHEN '4' THEN e.納入日 ELSE NULL END END END END END AS 完了日 ,a.担当者コード ,COALESCE(f.社員名,'') AS 担当者名 ,a.得意先コード ,CASE WHEN a.得意先コード = '1' THEN '1' ELSE '0' END as 得意先区分 ,CASE WHEN a.注文データ区分 = '' THEN '0' /* 伝送以外(black) */ ELSE CASE WHEN a.データ更新区分 = false THEN '1' /* 未更新(red) */ ELSE '2' /* 更新済み(blue) */ END END AS 色区分 ,d.依頼日
-- SQL_GET_ALL_FROM_CLAUSE
FROM T_受注 AS a LEFT OUTER JOIN T_生産計画 AS b ON b.管理No = a.管理No LEFT OUTER JOIN ( SELECT 管理No, MAX(分納No) AS 分納No FROM T_検査出荷依頼 GROUP BY 管理No ) AS c ON c.管理No = a.管理No LEFT OUTER JOIN T_検査出荷依頼 AS d ON d.管理No = c.管理No AND d.分納No = c.分納No LEFT OUTER JOIN T_売上 AS e ON e.管理No = d.管理No AND e.分納No = d.分納No LEFT OUTER JOIN M_社員 AS f ON f.社員コード = a.担当者コード
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    WHERE a.受注番号 &@ ? AND LENGTH(a.受注番号) = LENGTH(?) /*「受注番号」指定時 */
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.納期 DESC, a.受注番号 DESC, a.枝番 DESC

    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    WHERE a.品番 &@ ? AND LENGTH(a.品番) = LENGTH(?) /*「品番」指定時 */
        -- SQL_GET_ALL_WHERE_CLAUSE_SETTING_NO
        AND a.設変番号 = ? /*「設変番号」も同時に指定時 */
    -- SQL_GET_ALL_ORDER_BY_CLAUSE
    ORDER BY a.納期 DESC, a.受注番号 DESC, a.枝番 DESC


