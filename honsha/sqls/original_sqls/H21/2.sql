-- SQL_GETALL_CORE
SELECT a.管理No,a.分納No,b.受注番号,b.枝番,b.品番,b.設変番号,a.納入日,a.依頼数,a.結果登録日,NULL AS 売上登録日,'－' AS SMC現品票出力日,b.担当者コード,COALESCE(c.社員名,'') AS 担当者名,CASE WHEN b.得意先コード = '1' THEN '1' ELSE '0' END AS 得意先区分 FROM T_検査出荷依頼 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード WHERE a.出荷区分 IN ('1','2','3') AND (a.検査区分 = false OR (a.検査区分 = true AND a.検査結果区分 = '1')) AND NOT EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No AND 分納No = a.分納No)

    -- SQL_GETALL_ZYUCHUUBANGOU
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
    -- SQL_GETALL_TANTOUSYA
    AND b.担当者コード = ?
    
-- SQL_GETALL_ORDER_BY
ORDER BY b.品番, b.設変番号, a.納入日


