﻿-- SQL_ADD_ZUMEN_EXISTS
SELECT CAST(COUNT(SeqNo) AS INT) AS 件数 FROM T_図面 WHERE 図面種類 = ? AND 品番 = ? AND (CASE WHEN 図面種類 = '1' THEN 設変番号 ELSE 新設変番号 END) = ?


