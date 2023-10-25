-- SQL_GET_ALL
SELECT kogo, valid_start_DATE, valid_end_DATE, drawing_no, engineering_change_no, fixed_quantity, deadline, unit_price, prospected_quantity_per_quarter, fiscal_year_prospected_quantity FROM m_delivery_memos
    -- SQL_GET_ALL_WHERE_KOUGOU_CLAUSE
    WHERE kogo = ?
    
    -- SQL_GET_ALL_WHERE_ZUBAN_CLAUSE
    WHERE drawing_no LIKE ?
-- SQL_GET_ALL_ORDER_BY_CLAUSE
ORDER BY kogo
