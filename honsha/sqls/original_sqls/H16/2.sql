-- SQL_GET_PURCHASE_LIST
SELECT a.伝票番号 ,a.作業区コード ,COALESCE(c.作業区略称,'') AS 作業区名 ,a.工程コード ,COALESCE(d.工程略称,'') AS 工程名 ,a.発注日 ,a.納期 ,a.発注数 ,b.受注番号 ,b.枝番 FROM T_発注 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN M_工程 AS d ON d.工程コード = a.工程コード WHERE b.品番 &@ ? AND LENGTH(b.品番) = LENGTH(?) AND b.設変番号 = ? AND NOT EXISTS (SELECT * FROM T_検査出荷依頼 WHERE 管理No = a.管理No AND 納入形態区分 IN ('1','2','4','11','12')) ORDER BY a.発注日 DESC, a.管理No, a.工程順序No


