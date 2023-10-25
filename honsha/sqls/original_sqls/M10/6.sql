-- SQL_EXPORT_M10
SELECT a.得意先コード, a.品番, a.品名, a.最新設変番号, a.材質コード, c.材質名, a.材料形状コード, b.材料形状名, a.材料径, a.製品長 FROM M_部品 a LEFT OUTER JOIN M_材料形状 b ON a.材料形状コード = b.材料形状コード LEFT OUTER JOIN M_材質 c ON a.材質コード = c.材質コード ORDER BY a.品番
