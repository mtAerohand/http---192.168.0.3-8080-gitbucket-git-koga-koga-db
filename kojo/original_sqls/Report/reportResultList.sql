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

SQL_RESULTLIST_SETUHEN =
AND b.設変番号 = ? ;

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

SQL_RESULTLIST_ORDER =
GROUP BY b.受注番号, b.枝番 
) AS x 
) AS y 
ORDER BY y.受注番号, y.枝番, y.区分, y.作業日, y.作業区名漢字, y.機械名;
