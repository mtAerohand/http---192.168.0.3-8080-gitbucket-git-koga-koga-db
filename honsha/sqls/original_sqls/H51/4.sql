-- SQL_GET_ALL
SELECT a.品番,a.設変番号,a.材質コード,COALESCE(b.材質名,'') AS 材質名,a.材料形状コード,COALESCE(c.材料形状名,'') AS 材料形状名,a.入力方法,a.正味材料費,a.材質ベース単価,a.材料費補正額,a.登録日 FROM T_材料計算 AS a LEFT OUTER JOIN M_材質 AS b ON b.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS c ON c.材料形状コード = a.材料形状コード WHERE a.品番 &^ ? ORDER BY a.品番, a.設変番号


