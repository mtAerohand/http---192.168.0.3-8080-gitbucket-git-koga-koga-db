-- SQL_GET_ALL
SELECT 帳票No ,帳票名 ,CASE WHEN ファイル形式区分 = '1' THEN 'PDF' ELSE 'Excel' END AS ファイル形式名 ,CASE WHEN 出力先区分 = '1' THEN 'プリンタ' ELSE 'ダウンロード' END AS 出力先名 ,CASE WHEN 出力先区分 = '1' THEN プリンタ名 ELSE '' END AS プリンタ名 FROM M_印刷制御 ORDER BY 帳票No


