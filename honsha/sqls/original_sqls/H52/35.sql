-- SQL_REPORT_71_COUNT_TEMPLATE
SELECT CAST(COUNT(a.品番) AS INT) %s %s %s
-- SQL_REPORT_71_COMMON
FROM T_材料計算 AS a LEFT OUTER JOIN M_部品 AS b ON b.品番 = a.品番 LEFT OUTER JOIN M_材質 AS c ON c.材質コード = a.材質コード LEFT OUTER JOIN M_材料形状 AS d ON d.材料形状コード = a.材料形状コード
    -- SQL_REPORT_71_WHERE_HINBAN
    WHERE a.品番 &^ ?
    -- SQL_REPORT_71_ORDERBY
    ORDER BY a.品番, a.設変番号


