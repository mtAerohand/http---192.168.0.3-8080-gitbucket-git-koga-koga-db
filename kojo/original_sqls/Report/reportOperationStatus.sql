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

