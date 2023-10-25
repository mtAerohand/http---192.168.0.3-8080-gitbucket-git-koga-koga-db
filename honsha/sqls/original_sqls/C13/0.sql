-- SQL_GET_ALL
SELECT 作業区コード,作業区名,作業区略称,支払方法 FROM M_作業区仕入先 WHERE 分類 = '1' AND CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,作業区コード


