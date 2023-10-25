SCHEDULE =
SELECT
  K.作業区コード, SA.作業区名漢字, K.機械コード, KI.機械名, KI.担当コード, TA.担当名,
  CASE RTRIM(K.枝番) WHEN '' THEN K.受注番号 ELSE K.受注番号 || ' (' || K.枝番 || ')' END AS 表示受注番号,
  CASE RTRIM(K.設変番号) WHEN '' THEN K.部品番号 WHEN '0' THEN K.部品番号 WHEN '00' THEN K.部品番号 ELSE K.部品番号 || ' (' || K.設変番号 || ')' END AS 表示部品番号,
  K.部品名, K.加工数, K.納期, CAST(JU.回答日 as DATE), K.計画開始日, K.計画終了日
FROM T_工程計画 AS K
INNER JOIN V_工場作業区ALL AS SA
ON SA.作業区コード = K.作業区コード
INNER JOIN M_機械 AS KI
ON KI.作業区コード = K.作業区コード AND KI.機械コード = K.機械コード
LEFT OUTER JOIN
(
  SELECT 伝票番号, MIN(回答日) AS 回答日
  FROM V_工場受注情報
  WHERE 回答日 <> ''
  GROUP BY 伝票番号
) AS JU
ON JU.伝票番号 = K.伝票番号
LEFT OUTER JOIN M_担当 AS TA
ON KI.作業区コード = TA.作業区コード AND KI.担当コード = TA.担当コード
WHERE K.作業区コード = ? AND K.機械コード = ? AND CAST(? as DATE) <= K.計画開始日
ORDER BY K.計画開始日;