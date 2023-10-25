GET_PLAN_LIST =
SELECT
 K.計画NO
 ,K.作業区コード
 ,K.機械コード
 ,KI.機械名
 ,COALESCE(KI.担当コード, '0') AS 担当コード
 ,TA.担当名
 ,CASE RTRIM(K.枝番) WHEN '' THEN K.受注番号 ELSE K.受注番号 || ' (' || K.枝番 || ')' END AS 表示受注番号
 ,K.伝票番号
 ,CASE RTRIM(K.設変番号) WHEN '' THEN K.部品番号 WHEN '0' THEN K.部品番号 WHEN '00' THEN K.部品番号 ELSE K.部品番号 || ' (' || K.設変番号 || ')' END AS 表示部品番号
 ,COALESCE(K.部品名,'') AS 部品名
 ,COALESCE(K.工程略名,'') AS 工程略名
 ,K.納期
 ,K.加工数
 ,COALESCE(K.備考,'') AS 備考
 ,K.計画開始日
 ,K.計画終了日
 ,KS.セット有無区分
 ,COALESCE(JU.回答日, '') AS 回答日
 ,CASE WHEN JU2.伝票番号 IS NULL THEN '1' ELSE '0' END AS 受注取消区分
 ,CASE WHEN JU2.納品形態 = '1' THEN '1' WHEN JU2.納品形態 = '2' THEN '1' WHEN KJ.計画NO IS NOT NULL THEN '2' ELSE '3' END AS 作業状況
FROM T_工程計画 AS K
INNER JOIN M_機械 AS KI
ON KI.作業区コード = K.作業区コード AND KI.機械コード = K.機械コード
INNER JOIN (
    SELECT
    KS1.計画NO
    ,CASE WHEN KS2.セット時間有無 = true THEN '1' ELSE '0' END AS セット有無区分
    FROM (
        SELECT
        計画NO
        ,MIN(工程NO) AS 工程NO
        FROM T_工程計画詳細
        GROUP BY 計画NO
    ) AS KS1
    INNER JOIN T_工程計画詳細 AS KS2
    ON KS1.計画NO = KS2.計画NO AND KS1.工程NO = KS2.工程NO
) AS KS
ON KS.計画NO = K.計画NO
LEFT OUTER JOIN (
    SELECT
    伝票番号
    ,MIN(回答日) AS 回答日
    FROM V_工場受注情報
    WHERE 回答日 IS NOT NULL
    AND 回答日 <> ''
    GROUP BY 伝票番号
) AS JU
ON JU.伝票番号 = K.伝票番号
LEFT OUTER JOIN (
    SELECT DISTINCT
    伝票番号
    ,納品形態
    FROM V_工場受注情報
) AS JU2
ON JU2.伝票番号 = K.伝票番号
LEFT OUTER JOIN (
    SELECT DISTINCT
    計画NO
    FROM T_加工実績
) AS KJ
ON K.計画NO = KJ.計画NO
LEFT OUTER JOIN M_担当 AS TA
ON KI.作業区コード = TA.作業区コード AND KI.担当コード = TA.担当コード;

GET_PLAN_LIST_RECORD =
SELECT K.作業区コード, K.部品番号, COALESCE(K.部品名, ''), CASE RTRIM(K.枝番) WHEN '' THEN K.受注番号 ELSE K.受注番号 || ' (' || K.枝番 || ')' END AS 表示受注番号
 ,K.加工数, K.設変番号, COALESCE(K.工程略名, ''), KI.機械名, TA.担当名, KS.工程NO, KS.セット時間, KS.加工秒数/個, KS.加工数/日
 ,CASE WHEN KS.セット時間有無 = true THEN KS.セット開始日 ELSE KS.加工開始日 END AS 計画開始日,KS.終了日 AS 計画終了日
FROM T_工程計画 AS K
INNER JOIN T_工程計画詳細 AS KS ON KS.計画NO = K.計画NO
INNER JOIN M_機械 AS KI ON KI.作業区コード = K.作業区コード AND KI.機械コード = K.機械コード
LEFT OUTER JOIN M_担当 AS TA ON KI.作業区コード = TA.作業区コード AND KI.担当コード = TA.担当コード
WHERE K.作業区コード = ? AND K.部品番号 = ?
ORDER BY K.計画開始日 DESC, K.計画NO, KS.工程NO;

PLAN_GET =
SELECT K.計画NO, K.作業区コード, SA.作業区名漢字, K.機械コード, KI.機械名, COALESCE(KI.担当コード, '0') AS 担当コード, TA.担当名, K.受注番号, K.枝番, K.伝票番号, K.部品番号,
K.設変番号, COALESCE(K.部品名, '') AS 部品名, K.納期, K.受注数, K.加工数, COALESCE(K.備考, '') AS 備考,
K.稼動時間, K.計算区分, K.計画開始日, K.計画終了日, K.バージョン番号,
COALESCE((SELECT MIN(回答日) FROM V_工場受注情報 WHERE 伝票番号 = K.伝票番号 AND 回答日 <> ''),'') AS 回答日,
KS.工程NO, KS.最終工程区分, KS.セット時間有無, KS.セット時間,
KS.加工秒数/個, KS.係数, KS.加工時間計, KS.セット日数, KS.加工数/日, KS.加工日数,
KS.セット開始日, KS.セット開始時刻, KS.加工開始日, KS.加工開始時刻, KS.終了日, KS.終了時刻, KS.バージョン番号
FROM T_工程計画 AS K
INNER JOIN V_工場作業区ALL AS SA
ON SA.作業区コード = K.作業区コード
INNER JOIN M_機械 AS KI
ON KI.作業区コード = K.作業区コード AND KI.機械コード = K.機械コード
INNER JOIN T_工程計画詳細 AS KS
ON KS.計画NO = K.計画NO
LEFT OUTER JOIN M_担当 AS TA
ON KI.作業区コード = TA.作業区コード AND KI.担当コード = TA.担当コード
WHERE K.計画NO = CAST(? as INT)
ORDER BY KS.工程NO;

PLAN_GET_RECORD =
SELECT K.作業区コード, K.機械コード, K.部品番号, K.設変番号, K.備考, K.稼動時間, K.計算区分, KS2.工程NO, KS2.最終工程区分,
KS2.セット時間有無, KS2.セット時間, KS2.加工秒数/個, KS2.加工数/日
FROM T_工程計画 AS K
INNER JOIN (SELECT 作業区コード, 機械コード, 部品番号, MAX(計画NO) AS 計画NO
            FROM T_工程計画
            WHERE 作業区コード = ? AND 機械コード = ? AND 部品番号 = ?
            GROUP BY 作業区コード, 機械コード, 部品番号) AS K2
ON K2.計画NO = K.計画NO
INNER JOIN (SELECT K4.作業区コード, K4.機械コード, K4.部品番号, K4.計算区分, K4.工程NO, MAX(K4.計画NO) AS 計画NO
            FROM (
                SELECT K3.計画NO, K3.作業区コード, K3.機械コード, K3.部品番号, K3.計算区分, KS.工程NO
                FROM T_工程計画 AS K3
                INNER JOIN T_工程計画詳細 AS KS
                ON KS.計画NO = K3.計画NO
                WHERE 作業区コード = ? AND 機械コード = ? AND 部品番号 = ?
            ) AS K4
            GROUP BY K4.作業区コード, K4.機械コード, K4.部品番号, K4.計算区分, K4.工程NO) AS K5
ON K5.作業区コード = K.作業区コード AND K5.機械コード = K.機械コード AND K5.部品番号 = K.部品番号 AND K5.計算区分 = K.計算区分
INNER JOIN T_工程計画詳細 AS KS2
ON KS2.計画NO = K5.計画NO AND KS2.工程NO = K5.工程NO
ORDER BY KS2.工程NO;

PLAN_GET_PLAN_DETAIL =
SELECT
  koutei.作業区コード, koutei.機械コード, koutei.受注番号, koutei.枝番,
  koutei.伝票番号, koutei.部品番号, koutei.設変番号,
  koutei.部品名, koutei.工程略名,
  koutei.受注日,
  koutei.納期,
  koutei.受注数,
  koutei.加工数, koutei.備考, koutei.稼動時間, koutei.計算区分,
  koutei.バージョン番号,
  detail.計画NO, detail.工程NO, detail.最終工程区分,
  detail.セット時間有無, detail.セット時間, detail.加工秒数/個,
  detail.係数, detail.加工時間計, detail.セット日数, detail.加工数/日,
  detail.加工日数,
  detail.セット開始日,
  detail.セット開始時刻,
  detail.加工開始日,
  detail.加工開始時刻,
  detail.終了日, detail.終了時刻
FROM T_工程計画詳細 as detail
JOIN T_工程計画 as koutei
ON detail.計画NO = koutei.計画NO
WHERE detail.計画NO = CAST(? as INT)
ORDER BY detail.工程NO;

PLAN_GET_BEGIN_DAY =
SELECT
  作業区コード, 機械コード, MAX(計画終了日) + interval '1 day' AS 計画開始日
FROM T_工程計画
WHERE 作業区コード = ?
  AND 機械コード = ?
  AND 計画開始日 >= CURRENT_DATE
GROUP BY 作業区コード, 機械コード;


