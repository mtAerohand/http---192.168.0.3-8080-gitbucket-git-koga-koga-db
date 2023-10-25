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