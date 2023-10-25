-- SQL_GET_DATA
SELECT a.管理No,a.分納No,b.受注番号,b.枝番,b.品番,b.設変番号,a.バージョン番号,依頼数 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No WHERE a.管理No = CAST(? AS INT) AND a.検査区分 = true AND a.検査結果区分 = '0'


