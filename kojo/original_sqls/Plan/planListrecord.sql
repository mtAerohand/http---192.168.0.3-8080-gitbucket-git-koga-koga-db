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
