-- SQL_EXISTS_SELECT_ZAIRYOU
SELECT CASE WHEN EXISTS(SELECT * FROM T_仕入 WHERE 取引区分 = '1' AND 取引分類 = '1' AND 仕入先コード = ? AND 材質名 = ? AND 形状 = ? AND 取引日 = CAST(? as DATE) %s ) THEN 1 ELSE 0 END AS 判定
    -- SQL_EXISTS_WHERE_UPDATE(上文の%sに挿入する/しない)
    AND SeqNo <> CAST(? AS INT)


