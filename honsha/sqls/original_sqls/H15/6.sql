-- SQL_GETALL_SAISYUTSURYOKU_SELECT
SELECT a.管理No,b.受注番号,b.枝番,b.品番,b.設変番号,b.受注日,b.納期,f.工程順序No,f.作業区コード,COALESCE(g.作業区略称,'') AS 作業区名,e.発注日,b.担当者コード,COALESCE(c.社員名,'') AS 担当者名,b.得意先コード,COALESCE(d.得意先略称,'') AS 得意先名 FROM T_生産計画 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No AND b.受注区分 <> '2' LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = b.得意先コード INNER JOIN (SELECT DISTINCT 管理No, 発注日 FROM T_発注 WHERE 発注日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)) AS e ON e.管理No = a.管理No INNER JOIN T_生産計画詳細 AS f ON f.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS g ON g.作業区コード = f.作業区コード WHERE 1=1
    -- SQL_GETALL_SAISYUTSURYOKU_TANTOUSYA
    AND b.担当者コード = ?
    -- SQL_GETALL_SAISYUTSURYOKU_ZYUCHUUBANGOU
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
    -- SQL_GETALL_SAISYUTSURYOKU_HINBAN
    AND b.品番 &@ ? AND LENGTH(b.品番) = LENGTH(?)
-- SQL_GETALL_SAISYUTSURYOKU_ORDER_BY
ORDER BY b.受注番号, b.枝番, f.工程順序No


