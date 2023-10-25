-- SQL_PRICE
SELECT 材質コード,材質ベース単価 FROM M_材質ベース単価 WHERE 材質コード = ? AND CURRENT_DATE BETWEEN 適用開始日 AND 適用終了日


