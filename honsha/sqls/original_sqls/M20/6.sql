﻿-- SQL_GET_ALL_COUNT_BY_WCODE
SELECT CAST(COUNT(請求元) AS INT) FROM M_納入バケット WHERE 請求元 = ? AND 次工程コード = ?


