BACKORDER =
SELECT
  a.作業区コード,
  COALESCE(c.作業区名,'') AS 作業区名,
  CASE RTRIM(b.枝番)
    WHEN '' THEN b.受注番号
    ELSE b.受注番号 || ' (' || RTRIM(b.枝番) || ')'
  END AS 表示受注番号,
  CASE RTRIM(b.設変番号)
    WHEN '' THEN b.品番
    WHEN '0' THEN b.品番
    WHEN '00' THEN b.品番
    ELSE b.品番 || ' (' || RTRIM(b.設変番号) || ')'
  END AS 表示部品番号,
  a.発注日 AS 受注日,
  a.納期,
  d.回答日,
  a.発注数 AS 受注数,
  a.単価,
  CAST(FLOOR(a.単価 * a.発注数) as BIGINT) AS 受注金額,
  CASE WHEN e.計画NO IS NULL THEN '' ELSE '済' END AS 計画,
  COALESCE(g.作業区名,'') AS 前工程作業区名,
  f.納期 AS 前工程納期,
  h.回答日 AS 前工程回答日,
  i.受入日 AS 前工程納品日,
  COALESCE(j.受入数,0) AS 前工程納品数
FROM 本社DB.T_発注 AS a
INNER JOIN 本社DB.T_受注 AS b
ON b.管理No = a.管理No
LEFT OUTER JOIN 本社DB.M_作業区仕入先 AS c
ON c.作業区コード = a.作業区コード
LEFT OUTER JOIN (
  SELECT 管理No, 工程順序No, MIN(回答日) AS 回答日
  FROM 本社DB.T_納期回答依頼
  GROUP BY 管理No, 工程順序No
) AS d
ON d.管理No = a.管理No
AND d.工程順序No = a.工程順序No
LEFT OUTER JOIN (
  SELECT 伝票番号,MIN(計画NO) AS 計画NO
  FROM T_工程計画
  GROUP BY 伝票番号
) AS e
ON e.伝票番号 = CAST(a.伝票番号 as VARCHAR(6))
LEFT OUTER JOIN 本社DB.T_生産計画詳細 AS f
ON f.管理No = a.管理No
AND f.工程順序No = (a.工程順序No - 1)
LEFT OUTER JOIN 本社DB.M_作業区仕入先 AS g
ON g.作業区コード = f.作業区コード
LEFT OUTER JOIN (
  SELECT 管理No, 工程順序No, MIN(回答日) AS 回答日
  FROM 本社DB.T_納期回答依頼
  GROUP BY 管理No, 工程順序No
) AS h
ON h.管理No = f.管理No
AND h.工程順序No = f.工程順序No
LEFT OUTER JOIN (
  SELECT 管理No, 工程順序No, MIN(受入日) AS 受入日
  FROM 本社DB.T_工程受入
  GROUP BY 管理No, 工程順序No
) AS i
ON i.管理No = f.管理No
AND i.工程順序No = f.工程順序No
LEFT OUTER JOIN 本社DB.T_工程受入 AS j
ON j.管理No = i.管理No
AND j.工程順序No = i.工程順序No
AND j.受入日 = i.受入日
WHERE NOT EXISTS (SELECT * FROM 本社DB.T_工程受入 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No AND 受入形態区分 IN ('1','2'))
AND a.作業区コード = ?
AND a.発注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
ORDER BY 表示部品番号, a.発注日, a.納期;
