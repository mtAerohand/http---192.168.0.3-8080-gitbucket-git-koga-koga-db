RESULT_SHEET =
SELECT
  KI.作業区コード, SA.作業区名漢字, KI.機械コード, KI.機械名,
  CASE WHEN RTRIM(K.枝番) IS NULL THEN '' WHEN RTRIM(K.枝番) = '' THEN K.受注番号 ELSE K.受注番号 || ' (' || K.枝番 || ')' END AS 表示受注番号,
  CASE WHEN RTRIM(K.設変番号) IS NULL THEN '' WHEN RTRIM(K.設変番号) = '' OR RTRIM(K.設変番号) = '0' OR RTRIM(K.設変番号) = '00' THEN K.部品番号 ELSE K.部品番号 || ' (' || K.設変番号 || ')' END AS 表示部品番号
FROM M_機械 AS KI
INNER JOIN V_工場作業区ALL AS SA
ON SA.作業区コード = KI.作業区コード
LEFT OUTER JOIN T_工程計画 AS K
ON K.作業区コード = KI.作業区コード AND K.機械コード = KI.機械コード
AND CAST(? as DATE) BETWEEN K.計画開始日 AND K.計画終了日
WHERE KI.作業区コード = ? AND CAST(? as DATE) BETWEEN  KI.有効開始日 AND KI.有効終了日
ORDER BY KI.表示順, 表示部品番号;

