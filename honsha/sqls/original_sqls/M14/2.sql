﻿-- SQL_UPDATE_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM M_作業区担当者 WHERE ユーザID = ? AND NOT (作業区コード = ? AND 担当者コード = ?)) THEN 1 ELSE 0 END AS 判定

