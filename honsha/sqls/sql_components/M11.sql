﻿-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(得意先コード) AS INT) FROM M_得意先
-- SQL_GET_ALL
SELECT 得意先コード,有効開始日,有効終了日,得意先名,郵便番号1,郵便番号2,住所1,住所2,表示順 FROM M_得意先
-- SQL_GET_ALL_WHERE_CLAUSE
WHERE 得意先名 LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,得意先コード
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?

