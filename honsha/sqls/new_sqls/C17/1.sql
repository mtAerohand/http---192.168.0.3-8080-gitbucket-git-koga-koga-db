-- SQL_GET
SELECT process_code ,process_name ,process_abbreviation FROM m_processes WHERE CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE AND process_code = ?
