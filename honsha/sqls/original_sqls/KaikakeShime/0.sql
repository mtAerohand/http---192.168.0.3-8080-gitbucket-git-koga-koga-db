SELECT CASE WHEN 買掛締め月 < ? THEN 0 
WHEN 買掛締め月 = ? AND 実施状態区分 = '1' THEN 2
ELSE 1
END AS 判定
FROM M_システム