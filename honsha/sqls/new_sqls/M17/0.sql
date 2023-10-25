-- SQL_PLACES
SELECT CASE WHEN EXISTS(SELECT * FROM m_delivery_places WHERE customer_code = ? AND delivery_place_code = ?) THEN 1 ELSE 0 END AS 判定


