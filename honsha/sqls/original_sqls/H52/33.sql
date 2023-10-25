-- SQL_REPORT_71_SELECT_TEMPLATE
SELECT a.品番 ,a.設変番号 ,COALESCE(b.品名,'') AS 品名 ,a.材質コード ,COALESCE(c.材質名,'') AS 材質名 ,a.材料形状コード ,COALESCE(d.材料形状名,'') AS 材料形状名 ,a.材料径 ,a.材料長 ,a.製品長 ,a.残材長 ,a.入力方法 ,a.材質ベース単価 ,a.材料重量 ,a.材料単価 ,a.取数 ,a.材料費 ,a.製品材料重量 ,a.製品重量 ,a.くず回収率 ,a.くず単価 ,a.くず金額 ,a.正味材料費 ,a.材料費補正額 ,a.登録日 %s %s %s
-- SQL_REPORT_71_COMMON
FROM T_材料計算 AS a LEFT OUTER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS d ON d.材料形状コード = a.材料形状コード
    -- SQL_REPORT_71_WHERE_HINBAN
    WHERE a.品番 &^ ?
    -- SQL_REPORT_71_ORDERBY
    ORDER BY a.品番, a.設変番号


