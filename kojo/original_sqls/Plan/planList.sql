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
