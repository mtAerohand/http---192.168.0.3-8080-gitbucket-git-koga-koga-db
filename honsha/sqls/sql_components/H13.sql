-- SQL_BASE
SELECT a.管理No ,a.受注番号 ,a.枝番 ,a.品番 ,a.設変番号 ,a.品名 ,a.受注日 ,a.納期 ,a.受注数 ,a.担当者コード ,COALESCE(b.社員名,'') AS 担当者名 ,a.注文書出力日 ,a.注文コメント ,CASE WHEN c.受注日 IS NULL THEN '無' ELSE '有' END AS 先行手配有無 ,CASE a.注文データ区分 WHEN 'A' THEN '1' ELSE '2' END AS 注文書種別 ,a.注文バーコード番号 ,a.バージョン番号 ,CASE WHEN EXISTS (SELECT * FROM T_売上 WHERE 管理No = a.管理No) THEN '1' ELSE '0' END AS 売上区分 FROM T_受注 AS a LEFT OUTER JOIN M_社員 AS b ON b.社員コード = a.担当者コード LEFT OUTER JOIN ( SELECT DISTINCT 受注日, 品番, 設変番号 FROM T_先行手配 ) AS c ON c.受注日 = a.受注日 AND c.品番 = a.品番 AND c.設変番号 = a.設変番号 WHERE a.受注区分 = '2' AND a.注文データ区分 <> '' AND a.登録日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_ORDER
AND a.受注番号 &@ ? AND LENGTH(a.受注番号) = LENGTH(?)
-- SQL_PARTS
AND a.品番 &@ ? AND LENGTH(a.品番) = LENGTH(?)
-- SQL_ONCE
AND a.管理No = CAST(? as INT)
-- SQL_BY
ORDER BY a.登録日, a.品番
-- SQL_GET_PRECEDE
SELECT a.管理No ,a.品番 ,a.設変番号 ,a.品名 ,a.受注日 ,COALESCE(b.受注番号符号,'') AS 受注番号符号 ,CASE WHEN b.登録日 IS NULL THEN TO_CHAR(CURRENT_TIMESTAMP, 'YYMMDD') || '-XXX' ELSE TO_CHAR(b.登録日, 'YYMMDD') || '-XXX' END AS 受注番号固定部 ,a.担当者コード ,COALESCE(c.社員名,'') AS 担当者名 ,b.分納No ,b.納期 ,b.生産数 ,b.督促区分 ,b.備考 ,b.登録日 FROM T_受注 AS a LEFT OUTER JOIN T_先行手配 AS b ON b.受注日 = a.受注日 AND b.品番 = a.品番 AND b.設変番号 = a.設変番号 LEFT OUTER JOIN M_社員 AS c ON c.社員コード = a.担当者コード WHERE a.管理No = CAST(? as INT) ORDER BY b.分納No
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?

