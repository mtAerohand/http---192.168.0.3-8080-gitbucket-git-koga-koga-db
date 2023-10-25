-- SQL_GETALL_UPDATE_CORE
SELECT a.管理No,a.分納No,b.受注番号,b.枝番,b.品番,b.設変番号,a.納入日,a.依頼数,d.結果登録日,a.登録日,CASE WHEN e.印刷日 IS NULL THEN '－' ELSE TO_CHAR(e.印刷日, 'YYYY/MM/DD') END AS 印刷日,b.担当者コード,COALESCE(c.社員名,'') AS 担当者名,CASE WHEN b.得意先コード = '1' THEN '1' ELSE '0' END AS 得意先区分 FROM T_売上 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_社員 AS c ON c.社員コード = b.担当者コード INNER JOIN T_検査出荷依頼 AS d ON d.管理No = a.管理No AND d.分納No = a.分納No AND d.出荷区分 IN ('1','2','3') LEFT OUTER JOIN ( SELECT 管理No ,分納No ,MAX(印刷日) AS 印刷日 FROM T_現品票 GROUP BY 管理No,分納No ) AS e ON e.管理No = a.管理No AND e.分納No = a.分納No WHERE a.登録日 BETWEEN CAST(CASE WHEN ? = '' THEN '2000-01-01' ELSE ? END as DATE) AND CAST(CASE WHEN ? = '' THEN '9999-12-31' ELSE ? END as DATE)

    -- SQL_GETALL_ZYUCHUUBANGOU
    AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
    -- SQL_GETALL_TANTOUSYA
    AND b.担当者コード = ?

-- SQL_GETALL_ORDER_BY
ORDER BY b.品番, b.設変番号, a.納入日
