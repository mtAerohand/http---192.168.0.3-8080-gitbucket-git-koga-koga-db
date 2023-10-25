-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.品番) AS INT) FROM T_材料計算 AS a LEFT OUTER JOIN M_材質 AS b ON b.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS c ON c.材料形状コード = a.材料形状コード WHERE a.品番 &^ ?


