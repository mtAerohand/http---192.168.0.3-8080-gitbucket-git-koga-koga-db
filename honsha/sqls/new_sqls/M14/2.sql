-- SQL_UPDATE_CHECK
SELECT CASE WHEN EXISTS(SELECT * FROM m_supplier_managers WHERE user_id = ? AND NOT (supplier_code = ? AND manager_code = ?)) THEN 1 ELSE 0 END AS 判定


