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

SQL_PARTS =
SELECT a.作業区コード,b.作業区名漢字,
 a.機械コード, c.機械名, e.担当コード, e.担当名, a.部品番号, d.部品名 
FROM (SELECT DISTINCT 作業区コード, 機械コード, 部品番号 
FROM T_工程計画 WHERE 作業区コード = ? 
AND 機械コード = ?) a 
INNER JOIN V_工場作業区 AS b 
ON b.作業区コード = a.作業区コード 
INNER JOIN M_機械 AS c 
ON c.作業区コード = a.作業区コード 
AND c.機械コード = a.機械コード 
INNER JOIN V_部品 AS d 
ON d.部品番号 = a.部品番号 
LEFT OUTER JOIN M_担当 AS e 
ON e.作業区コード = c.作業区コード AND e.担当コード = c.担当コード 
ORDER BY a.部品番号;


SQL_RESULTLIST =
SELECT * FROM ( 
SELECT CASE RTRIM(b.枝番) 
          WHEN '' THEN b.受注番号 
          ELSE b.受注番号 || ' (' || RTRIM(b.枝番) || ')' 
       END AS 表示受注番号 
      ,TO_CHAR(b.受注数, 'FM99,999,999')  AS 受注数 
      ,d.作業区名漢字 
      ,c.機械名 
      ,TO_CHAR(a.作業日,'YYYY/MM/DD') AS 作業日 
      ,a.加工数 
      ,a.不良数 
      ,CASE WHEN a.加工数 = 0 
         THEN 0 
         ELSE ROUND(CAST(a.不良数 as NUMERIC) / a.加工数 * 100, 3) 
       END  AS 不良率 
      ,1 AS 区分 
      ,b.受注番号 
      ,b.枝番 
FROM T_加工実績 AS a 
INNER JOIN T_工程計画 AS b 
ON b.計画NO = a.計画NO 

INNER JOIN M_機械 AS c 
ON c.作業区コード = b.作業区コード 
AND c.機械コード = b.機械コード 
AND a.作業日 BETWEEN c.有効開始日 AND c.有効終了日 

INNER JOIN V_工場作業区 AS d 
ON d.作業区コード = b.作業区コード 

WHERE a.作業日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
AND b.部品番号 = ? ;

SQL_RESULTLIST_UNION = 
UNION 
SELECT '' AS 表示受注番号 
      ,'' AS 受注数 
      ,'' AS 作業区名漢字 
      ,'' AS 機械名 
      ,'' AS 作業日 
      ,x.加工数計 
      ,x.不良数計 
      ,CASE WHEN x.加工数計 = 0 
         THEN 0 
         ELSE ROUND(CAST(x.不良数計 as NUMERIC) / x.加工数計 * 100, 3) 
       END  AS 不良率 
      ,2 AS 区分 
      ,x.受注番号 
      ,x.枝番 
FROM ( 
SELECT SUM(a.加工数) AS 加工数計 
      ,SUM(a.不良数) AS 不良数計 
      ,b.受注番号 
      ,b.枝番 
FROM T_加工実績 AS a 
INNER JOIN T_工程計画 AS b 
ON b.計画NO = a.計画NO 
WHERE a.作業日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) 
AND b.部品番号 = ? ;

SQL_RESULTLIST_SETUHEN =
AND b.設変番号 = ? ;

SQL_RESULTLIST_ORDER =
GROUP BY b.受注番号, b.枝番 
) AS x 
) AS y 
ORDER BY y.受注番号, y.枝番, y.区分, y.作業日, y.作業区名漢字, y.機械名;

SQL_OPERATION_STATUS =
SELECT
     DT.作業日
   , MK.作業区コード
   , MS.作業区名
   , MK.担当コード
   , COALESCE(MT.担当名, '') AS 担当名
   , MK.機械コード
   , MK.機械名
   , MK.表示順
   , COALESCE(HS.受注番号, '停止') AS 受注番号
   , HS.枝番
   , HS.部品番号
   , HS.設変番号
   , HS.部品名
   , HS.加工費
   , HS.生産数
   , HS.不良数
   , HS.TACT
   , HS.出来高
   , HS.運転時間
   , HS.備考 
 FROM (
   SELECT
     CAST(G AS DATE) AS 作業日 
   FROM GENERATE_SERIES(CAST(? AS DATE), CAST(? AS DATE), '1 days') AS G
 ) AS DT 
 INNER JOIN M_機械 AS MK 
   ON DT.作業日 BETWEEN MK.有効開始日 AND MK.有効終了日 
 INNER JOIN 本社DB.M_作業区仕入先 AS MS 
   ON MK.作業区コード = MS.作業区コード 
 LEFT OUTER JOIN M_担当 AS MT 
   ON MK.作業区コード = MT.作業区コード AND MK.担当コード = MT.担当コード 
 LEFT OUTER JOIN ( 
   SELECT
       KK.作業区コード
     , KK.機械コード
     , KK.受注番号
     , KK.枝番
     , KK.部品番号
     , KK.設変番号
     , KK.部品名
     , SS.加工費
     , KJ.作業日
     , KJ.加工数 AS 生産数
     , KJ.不良数
     , KS.加工秒数/個 AS TACT
     , SS.加工費 * (KJ.加工数 - KJ.不良数) AS 出来高
     , CAST((KJ.加工数 * KS.加工秒数/個) / 3600 AS NUMERIC(4, 1)) AS 運転時間
     , KJ.備考 
   FROM T_工程計画 AS KK 
   INNER JOIN T_工程計画詳細 AS KS 
     ON KK.計画NO = KS.計画NO 
   INNER JOIN T_加工実績 AS KJ 
     ON KS.計画NO = KJ.計画NO AND KS.工程NO = KJ.工程NO AND KJ.作業日  BETWEEN CAST(? AS DATE) AND CAST(? AS DATE) 
   LEFT OUTER JOIN 本社DB.T_受注 AS JC 
     ON KK.受注番号 = JC.受注番号 AND KK.枝番 = JC.枝番 
   INNER JOIN 本社DB.T_発注 AS HC 
     ON JC.管理No = HC.管理No AND KK.作業区コード = HC.作業区コード 
   INNER JOIN 本社DB.T_生産計画 AS SK 
     ON HC.管理No = SK.管理No 
   INNER JOIN 本社DB.T_生産計画詳細 AS SS 
     ON HC.管理No = SS.管理No AND HC.工程順序No = SS.工程順序No
 ) AS HS 
   ON MK.作業区コード = HS.作業区コード 
   AND MK.機械コード = HS.機械コード 
   AND DT.作業日 = HS.作業日 ;

SQL_OPERATION_STATUS_WORK_REGION_CODE =  MK.作業区コード = ?;

SQL_OPERATION_STATUS_MACHINE_CODE =  MK.機械コード = ?;

SQL_OPERATION_STATUS_ORDER = ORDER BY DT.作業日, MK.作業区コード, MK.表示順, HS.受注番号, HS.枝番;
