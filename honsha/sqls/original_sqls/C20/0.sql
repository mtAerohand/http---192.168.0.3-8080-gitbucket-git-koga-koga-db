-- SQL_GET_ALL
SELECT 材質コード,材質名,比重 FROM M_材質 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 ORDER BY 表示順,材質コード


