GET_ALL_LIST =
SELECT 作業区コード,担当コード,担当名
FROM M_担当
WHERE 作業区コード = ?
ORDER BY 担当コード;