﻿-- SQL_CHECK_INSPECTION_SHIPMENT_ACCEPTED
SELECT CASE WHEN EXISTS(SELECT * FROM T_検査出荷依頼 WHERE 管理No = ?) THEN 1 ELSE 0 END AS 判定

