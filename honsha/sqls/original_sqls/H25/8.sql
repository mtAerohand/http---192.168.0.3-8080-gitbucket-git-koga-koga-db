-- SQL_EXISTS_SELECT
SELECT CASE WHEN EXISTS(SELECT * FROM T_売上任意 WHERE 取引先区分 = ? AND 取引先コード = ? AND 品番 = ? AND 設変番号 = ? AND 売上日 = ? %s ) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入される/されない)
    AND SeqNo <> ?
