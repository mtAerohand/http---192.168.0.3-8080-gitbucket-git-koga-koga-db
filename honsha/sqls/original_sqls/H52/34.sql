-- SQL_REPORT_23_SELECT_TEMPLATE
SELECT c.作業区コード ,COALESCE(d.作業区名,'') AS 作業区名 ,b.品番 ,b.設変番号 ,b.品名 ,c.工程コード ,COALESCE(e.工程略称,'') AS 工程名 ,a.希望納入数 ,a.分納No ,b.受注番号 ,b.枝番 %s %s
    -- SQL_REPORT_23_COMMON
    FROM T_納期回答依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No INNER JOIN T_生産計画詳細 AS c ON c.管理No = a.管理No AND c.工程順序No = a.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS d ON d.作業区コード = c.作業区コード LEFT OUTER JOIN M_工程 AS e ON e.工程コード = c.工程コード WHERE a.回答日 IS NOT NULL AND a.回答日 = CAST(? as DATE) AND EXISTS (SELECT * FROM T_発注 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No) AND NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = a.管理No AND 工程順序No = a.工程順序No AND 分納No = a.分納No)
    -- SQL_REPORT_23_ORDERBY
    ORDER BY COALESCE(d.表示順,0), c.作業区コード, b.品番


