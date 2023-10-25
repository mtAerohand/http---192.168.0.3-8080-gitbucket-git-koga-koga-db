-- SQL_GETALL_SYUTSURYOKU_BUNNOU_SELECT
SELECT a.管理No,b.受注番号,b.枝番,b.品番,b.設変番号,b.受注日,b.納期,f.工程順序No,f.作業区コード,COALESCE(g.作業区略称,'') AS 作業区名,e.発注日,b.担当者コード,COALESCE(c.社員名,'') AS 担当者名,b.得意先コード,COALESCE(d.得意先略称,'') AS 得意先名 FROM T_生産計画 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No AND b.受注区分 <> '2' LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード LEFT OUTER JOIN M_得意先 AS d ON d.得意先コード = b.得意先コード INNER JOIN T_生産計画詳細 AS f ON f.管理No = a.管理No INNER JOIN T_発注 AS e ON e.管理No = f.管理No AND e.工程順序No = f.工程順序No LEFT OUTER JOIN M_作業区仕入先 AS g ON g.作業区コード = f.作業区コード WHERE NOT EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = f.管理No AND 工程順序No = f.工程順序No AND 受入形態区分 IN ('1','2')) AND EXISTS (SELECT * FROM T_工程受入 WHERE 管理No = f.管理No AND 工程順序No = f.工程順序No AND 受入形態区分 = '3' AND 受入日 BETWEEN CAST(? as DATE) AND CAST(? as DATE) AND 受入日 > COALESCE(e.分納発注書出力日,'2000-01-01')) AND COALESCE(g.分納発注書発行区分,false) = true
    -- SQL_GETALL_SYUTSURYOKU_BUNNOU_TANTOUSYA
    AND b.担当者コード = ?
    -- SQL_GETALL_SYUTSURYOKU_BUNNOU_ZYUCHUUBANGOU
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
    -- SQL_GETALL_SYUTSURYOKU_BUNNOU_HINBAN
    AND b.品番 &@ ? AND LENGTH(b.品番) = LENGTH(?)
-- SQL_GETALL_SYUTSURYOKU_BUNNOU_ORDER_BY
ORDER BY b.受注番号, b.枝番, f.工程順序No


