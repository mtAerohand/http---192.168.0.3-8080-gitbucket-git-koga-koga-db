SQL_PARTS =
SELECT a.supplier_code,b.supplier_name漢字,
a.machine_code, c.machine_name, e.machine_manager_code, e.machine_manager_name, a.part_no, d.part_name 
FROM (SELECT DISTINCT supplier_code, machine_code, part_no 
FROM m_process_plans WHERE supplier_code = ? 
AND machine_code = ?) a 
INNER JOIN V_工場作業区 AS b 
ON b.supplier_code = a.supplier_code 
INNER JOIN m_machines AS c 
ON c.supplier_code = a.supplier_code 
AND c.machine_code = a.machine_code 
INNER JOIN V_部品 AS d 
ON d.part_no = a.part_no 
LEFT OUTER JOIN m_machine_managers AS e 
ON e.supplier_code = c.supplier_code AND e.machine_manager_code = c.machine_manager_code 
ORDER BY a.part_no;
