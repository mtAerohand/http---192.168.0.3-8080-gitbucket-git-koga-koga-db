﻿-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM T_受入返品 WHERE 返品日 = CAST(? as DATE) AND 管理No = CAST(? AS INT) AND 工程順序No = CAST(? AS INT) %s ) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入する/しない)
    AND SeqNo <> CAST(? AS INT)
