-- SQL_GET_ALL
SELECT 工程コード,工程名,工程略称 FROM M_工程 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,工程コード
-- SQL_GET
SELECT 工程コード ,工程名 ,工程略称 FROM M_工程 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 AND 工程コード = ?

