-- SQL_GET
SELECT a.品番, a.最新設変番号, a.品名, a.材料費変動補正対象, a.材質コード, COALESCE(b.材質名,'') AS 材質名, a.材質ベース単価, a.材料費, a.材料費補正額, a.備考, a.バージョン番号, a.材料形状コード, a.材料径, a.製品長, a.得意先コード, COALESCE(c.得意先名,'') AS 得意先名 FROM M_部品 a LEFT OUTER JOIN M_材質 b ON a.材質コード = b.材質コード LEFT OUTER JOIN M_得意先 c ON a.得意先コード = c.得意先コード
-- SQL_GET_WHERE_CLAUSE
WHERE a.品番 = ?


