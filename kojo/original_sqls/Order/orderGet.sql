GET_BY_ORDER_NUMBER =
SELECT DISTINCT
受注番号, 枝番, 受注IDNO, 伝票番号, 部品番号, 設変番号, 部品名, 受注日
, 納期, 受注数, 作業区コード, 作業区名漢字, 工程コード, 工程名略,
 COALESCE(
(
SELECT
MIN(回答日)
FROM V_工場受注情報 AS a
WHERE
a.伝票番号 = b.伝票番号
AND
回答日 <> ''
GROUP BY 伝票番号
), '') as 回答日
FROM
V_工場受注情報 AS b
WHERE
伝票番号 = ?;