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
