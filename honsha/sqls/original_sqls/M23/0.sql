-- SQL_GET
SELECT a.材質コード,a.材質名,b.SeqNo,b.適用開始日,b.適用終了日,b.材質ベース単価,b.備考,b.バージョン番号 FROM M_材質 AS a LEFT OUTER JOIN M_材質ベース単価 AS b ON b.材質コード = a.材質コード WHERE a.材質コード = ? ORDER BY b.適用開始日


