-- SQL_GETALL_SELECT
SELECT seq_no ,CASE WHEN type = '1' THEN '仕掛品' ELSE '材料' END AS type ,part_no ,engineering_change_no ,quantity ,material_name ,shape ,weight ,unit_price ,assessment_rate ,price FROM t_inventories
    -- SQL_GETALL_WHERE_TANAOROSHI
    WHERE inventory_month = ? AND supplier_code = ?
    
    -- SQL_GETALL_WHERE_seq_no
    WHERE seq_no = CAST(? AS INT)
-- SQL_GETALL_ORDERBY
ORDER BY type, part_no, engineering_change_no, material_name, shape


