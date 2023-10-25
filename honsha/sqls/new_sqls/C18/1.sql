-- SQL_GET
SELECT customer_code ,delivery_place_code ,delivery_place_name FROM m_delivery_places WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE AND customer_code = ? AND delivery_place_code = ?
