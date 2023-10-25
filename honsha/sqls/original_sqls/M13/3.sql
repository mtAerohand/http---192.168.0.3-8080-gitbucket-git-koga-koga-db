-- SQL_GET_ALL
SELECT 作業区コード,作業区名,CASE 分類 WHEN '1' THEN '作業区' ELSE '材料仕入先' END AS 分類,CASE 作業区分類 WHEN '1' THEN '自社' WHEN '2' THEN '協力会社' ELSE '' END AS 作業区分類,CASE 検収書発行区分 WHEN true THEN '有り' ELSE '無し' END AS 検収書発行区分,CASE 支払方法 WHEN '1' THEN '現金' WHEN '2' THEN '手形' WHEN '3' THEN 'その他' ELSE '' END AS 支払方法,CASE 督促連絡方法 WHEN '1' THEN 'メール' WHEN '2' THEN 'Fax' ELSE '' END AS 督促連絡方法,表示順,有効開始日,有効終了日 ,CASE 分納発注書発行区分 WHEN true THEN '有り' ELSE '無し' END AS 分納発注書発行区分 FROM M_作業区仕入先
    -- SQL_GET_ALL_WHERE_CLAUSE_DIVISION
    WHERE 作業区コード = ?
    
    -- SQL_GET_ALL_WHERE_CLAUSE
    WHERE 分類 = ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY 表示順,作業区コード


