-- SQL_CHECK_FOR_DUPLICATE_PACKING
SELECT CAST(COUNT(part_no) AS INT) FROM m_packings WHERE part_no = ?
