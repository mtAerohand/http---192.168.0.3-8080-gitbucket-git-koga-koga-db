-- SQL_GET_REQUEST1
SELECT a.管理No ,COALESCE(b.分納数,1) AS 分納数 ,a.工程順序No ,a.作業区コード ,COALESCE(c.作業区略称,'') AS 作業区名 ,COALESCE(c.督促連絡方法,'2') AS 督促連絡方法 ,d.発注数 ,d.納期 FROM T_生産計画詳細 AS a LEFT OUTER JOIN ( SELECT 管理No ,MAX(分納No) AS 分納数 FROM T_納期回答依頼 GROUP BY 管理No ) AS b ON b.管理No = a.管理No LEFT OUTER JOIN M_作業区仕入先 AS c ON c.作業区コード = a.作業区コード LEFT OUTER JOIN T_発注 AS d ON d.管理No = a.管理No AND d.工程順序No = a.工程順序No WHERE a.管理No = CAST(? as INT) ORDER BY a.工程順序No


