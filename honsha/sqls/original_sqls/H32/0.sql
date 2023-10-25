-- SQL_GET_ALL_COUNT
SELECT CAST(COUNT(a.管理No) AS INT)
-- SQL_GET_ALL_FROM_CLAUSE
FROM T_受注 AS a LEFT OUTER JOIN T_生産計画 AS b ON b.管理No = a.管理No LEFT OUTER JOIN ( SELECT 管理No, MAX(分納No) AS 分納No FROM T_検査出荷依頼 GROUP BY 管理No ) AS c ON c.管理No = a.管理No LEFT OUTER JOIN T_検査出荷依頼 AS d ON d.管理No = c.管理No AND d.分納No = c.分納No LEFT OUTER JOIN T_売上 AS e ON e.管理No = d.管理No AND e.分納No = d.分納No LEFT OUTER JOIN M_社員 AS f ON f.社員コード = a.担当者コード
    -- SQL_GET_ALL_WHERE_CLAUSE_ORDER_NO
    WHERE a.受注番号 &@ ? AND LENGTH(a.受注番号) = LENGTH(?) /*「受注番号」指定時 */

    -- SQL_GET_ALL_WHERE_CLAUSE_PARTS_NO
    WHERE a.品番 &@ ? AND LENGTH(a.品番) = LENGTH(?) /*「品番」指定時 */

        -- SQL_GET_ALL_WHERE_CLAUSE_SETTING_NO
        AND a.設変番号 = ? /*「設変番号」も同時に指定時 */


