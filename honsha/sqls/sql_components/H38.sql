﻿-- SQL_GET_SELECT
SELECT b.管理No ,a.品番 ,a.設変番号 ,a.品名 ,a.在庫数 ,a.仮受在庫数 ,a.出荷依頼数 ,a.棚番1 ,a.棚番2 ,a.備考 ,a.バージョン番号 ,a.梱包区分 FROM M_在庫 AS a INNER JOIN T_受注 AS b ON b.品番 = a.品番 AND b.設変番号 = a.設変番号 AND b.管理No = CAST(? AS INT)

