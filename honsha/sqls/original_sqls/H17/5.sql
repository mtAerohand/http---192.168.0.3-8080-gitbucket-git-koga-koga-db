﻿-- SQL_BEFORE_PROCESS_COUNT
SELECT 受入数 FROM T_工程受入 WHERE 管理No = CAST(? as INT) AND 工程順序No = (CAST(? as INT) - 1) AND 分納No = CAST(? as INT)