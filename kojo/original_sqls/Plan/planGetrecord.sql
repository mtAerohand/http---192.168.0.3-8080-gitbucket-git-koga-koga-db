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