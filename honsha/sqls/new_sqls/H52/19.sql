-- SQL_REPORT_63_ALL
SELECT a.inventory_month ,a.supplier_code ,COALESCE(B.supplier_name,'') AS supplier_name ,a.仕掛品price + a.材料price AS 在庫price ,a.仕掛品price ,a.材料price FROM ( SELECT x.inventory_month ,x.supplier_code ,SUM(x.仕掛品price) AS 仕掛品price ,SUM(x.材料price) AS 材料price FROM ( SELECT inventory_month ,supplier_code ,CASE type WHEN '1' THEN price ELSE 0 END AS 仕掛品price ,CASE type WHEN '1' THEN 0 ELSE price END AS 材料price FROM t_inventories ) AS x GROUP BY x.inventory_month, x.supplier_code ) AS a LEFT OUTER JOIN m_suppliers AS b ON b.supplier_code = a.supplier_code WHERE a.inventory_month = ? ORDER BY COALESCE(b.sort_no,0), a.supplier_code


