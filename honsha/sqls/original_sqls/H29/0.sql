-- SQL_GET_PARAM
SELECT '1' AS 分類 ,CASE WHEN 実施状態区分 = '1' THEN 買掛締め月 ELSE LEFT(TO_CHAR(CAST(買掛締め月 || '01' as DATE) + interval '1 month','YYYYMMDD'),6) END AS 締め月 ,CASE WHEN 実施状態区分 = '1' THEN '済' ELSE '' END AS 状態 ,CASE WHEN 実施状態区分 = '1' THEN 仮締め実施日時 ELSE NULL END AS 実行日時 ,バージョン番号 FROM M_システム WHERE SeqNo = 1 UNION ALL SELECT '2' AS 分類 ,CASE WHEN 実施状態区分 = '1' THEN 買掛締め月 ELSE LEFT(TO_CHAR(CAST(買掛締め月 || '01' as DATE) + interval '1 month','YYYYMMDD'),6) END AS 締め月 ,'' AS 状態 ,NULL AS 実行日時 ,バージョン番号 FROM M_システム WHERE SeqNo = 1 ORDER BY 分類


