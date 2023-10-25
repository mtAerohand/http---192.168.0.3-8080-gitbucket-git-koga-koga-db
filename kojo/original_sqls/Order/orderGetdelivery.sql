GET_DELIVERY_SELF =
SELECT 受注番号,枝番,納期,受注数,部品番号,設変番号,部品名,回答日,回答納品数,納品日,納品数
FROM V_工場受注情報
WHERE 伝票番号 = ?
AND (回答日 <> '' OR 納品日 <> '')
ORDER BY cast(分納NO AS numeric);

GET_DELIVERY_PRIOR =
SELECT K.受注番号,K.枝番,K.納期,K.受注数,K.部品番号,K.設変番号,K.部品名,K2.回答日,K2.回答納品数,K2.納品日,K2.納品数
FROM
(
    SELECT DISTINCT 受注番号,枝番,受注IDNO,伝票番号,管理No,部品番号,設変番号,部品名,納期,受注数,前工程コード
    FROM V_工場受注情報
) AS K
INNER JOIN V_工場受注情報 AS K2
ON K2.管理No = K.管理No
AND K2.作業区コード = K.前工程コード
AND cast(K2.受注IDNO AS numeric) = cast(K.受注IDNO AS numeric) - 1
AND (K2.回答日 <> '' OR K2.納品日 <> '')
WHERE K.伝票番号 = ?
ORDER BY cast(K2.分納NO AS numeric);

LISTORDER_PREFIX =
SELECT * FROM (
SELECT a.作業区コード, b.受注番号, b.枝番, CASE RTRIM(b.枝番)
WHEN '' THEN b.受注番号
ELSE b.受注番号 || ' (' || RTRIM(b.枝番) || ')'
END AS 表示受注番号
, CAST(a.伝票番号 as VARCHAR(6)) AS 伝票番号
, b.品番 AS 部品番号
, b.設変番号
, CASE RTRIM(b.設変番号)
WHEN ''   THEN b.品番
WHEN '0'  THEN b.品番
WHEN '00' THEN b.品番
ELSE b.品番 || ' (' || RTRIM(b.設変番号) || ')'
END AS 表示部品番号
, b.品名 AS 部品名
, COALESCE(c.工程略称,'') AS 工程名略
, a.発注数 AS 受注数
, TO_CHAR(a.発注日,'YYYYMMDD') AS 受注日
, TO_CHAR(a.納期,'YYYYMMDD') AS 納期
, COALESCE(TO_CHAR(d.回答日,'YYYYMMDD'), '') AS 回答日
, CASE WHEN e.計画NO IS NULL THEN '0' ELSE '1' END AS 計画区分
, COALESCE(e.計画NO, 0) AS 計画NO
, CASE WHEN f.管理No IS NULL THEN '0' ELSE '1' END AS 納品区分
, COALESCE(h.作業区略称,'') AS 前工程作業区名略名
, COALESCE(TO_CHAR(g.納期,'YYYYMMDD'),'') AS 前工程納期
, COALESCE(TO_CHAR(i.回答日,'YYYYMMDD'),'') AS 前工程回答日
, COALESCE(TO_CHAR(j.受入日,'YYYYMMDD'),'') AS 前工程納品日
, COALESCE(k.受入数,0) AS 前工程納品数
FROM 本社DB.T_発注 AS a
INNER JOIN 本社DB.T_受注 AS b
ON b.管理No = a.管理No
LEFT OUTER JOIN 本社DB.M_工程 AS c
ON c.工程コード = a.工程コード
LEFT OUTER JOIN (
SELECT 管理No
, 工程順序No
, MIN(回答日) AS 回答日
FROM 本社DB.T_納期回答依頼
WHERE 回答日 IS NOT NULL
GROUP BY 管理No, 工程順序No
) AS d
ON d.管理No = a.管理No
AND d.工程順序No = a.工程順序No
LEFT OUTER JOIN (
SELECT 伝票番号
, MIN(計画NO) AS 計画NO
FROM T_工程計画
GROUP BY 伝票番号
) AS e
ON e.伝票番号 = CAST(a.伝票番号 as VARCHAR(6))
LEFT OUTER JOIN (
SELECT DISTINCT 管理No
, 工程順序No
FROM 本社DB.T_工程受入
WHERE 受入形態区分 IN ('1','2')
) AS f
ON f.管理No = a.管理No
AND f.工程順序No = a.工程順序No
LEFT OUTER JOIN 本社DB.T_生産計画詳細 AS g
ON g.管理No = a.管理No
AND g.工程順序No = (a.工程順序No - 1)
LEFT OUTER JOIN 本社DB.M_作業区仕入先 AS h
ON h.作業区コード = g.作業区コード
LEFT OUTER JOIN (
SELECT 管理No
, 工程順序No
, MIN(回答日) AS 回答日
FROM 本社DB.T_納期回答依頼
WHERE 回答日 IS NOT NULL
GROUP BY 管理No, 工程順序No
) AS i
ON i.管理No = g.管理No
AND i.工程順序No = g.工程順序No
LEFT OUTER JOIN (
SELECT 管理No
, 工程順序No
, MIN(受入日) AS 受入日
FROM 本社DB.T_工程受入
GROUP BY 管理No, 工程順序No
) AS j
ON j.管理No = g.管理No
AND j.工程順序No = g.工程順序No
LEFT OUTER JOIN 本社DB.T_工程受入 AS k
ON k.管理No = j.管理No
AND k.工程順序No = j.工程順序No
AND k.受入日 = j.受入日
) AS L
WHERE L.作業区コード = ?
AND L.受注日 BETWEEN ? AND ?;
