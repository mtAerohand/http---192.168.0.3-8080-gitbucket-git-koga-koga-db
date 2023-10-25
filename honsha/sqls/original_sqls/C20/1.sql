-- SQL_GET
SELECT 材質コード ,材質名 ,比重 FROM M_材質 WHERE CURRENT_DATE BETWEEN 有効開始日 AND 有効終了日 AND 材質コード = ?
