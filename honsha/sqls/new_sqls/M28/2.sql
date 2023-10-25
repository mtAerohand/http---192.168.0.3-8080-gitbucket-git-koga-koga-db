-- SQL_GETALL
SELECT part_no ,engineering_change_no ,part_name ,stock_quantity ,suspense_stock_quantity ,ship_request_quantity ,stock_quantity - ship_request_quantity AS 有効stock_quantity ,CASE WHEN bin_2 = '' THEN bin_1 ELSE bin_1 || '-' || bin_2 END AS bin ,remarks ,correct_quantity FROM m_stocks
-- SQL_GETALL_WHERE_CLAUSE
WHERE part_no LIKE ?
-- SQL_GETALL_ORDERBY_CLAUSE
ORDER BY part_no, engineering_change_no


