-- SQL_GET
SELECT 作業区コード, 作業区名, 作業区略称, 郵便番号1, 郵便番号2, 住所1, 住所2, 分類, 作業区分類, 検収書発行区分, 督促連絡方法, 支払方法 FROM M_作業区仕入先 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 AND 作業区コード = ?


