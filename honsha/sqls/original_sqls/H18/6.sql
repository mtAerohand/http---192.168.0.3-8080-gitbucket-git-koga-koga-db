﻿-- SQL_GET_LAST_TIME_DELIVERY
SELECT MAX(納入日) AS 納入日 FROM T_検査出荷依頼 WHERE 管理No = CAST(? as INT) AND 分納No <> CAST(? as INT)
