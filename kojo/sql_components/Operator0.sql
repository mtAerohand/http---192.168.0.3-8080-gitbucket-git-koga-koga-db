operatorGetall
GET_ALL_LIST =
SELECT 作業区コード,担当コード,担当名
FROM M_担当
WHERE 作業区コード = ?
ORDER BY 担当コード;

operatorGet
GET_BY_WORK_REGION_ID_AND_OPERATOR_ID =
SELECT 作業区コード,担当コード,担当名,バージョン番号
FROM M_担当
WHERE 作業区コード = ? AND 担当コード = ?;
