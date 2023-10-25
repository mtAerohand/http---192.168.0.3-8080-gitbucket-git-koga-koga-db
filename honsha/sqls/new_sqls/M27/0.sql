-- SQL_GET_ALL
SELECT print_control_no ,report_name ,CASE WHEN file_format_type = '1' THEN 'PDF' ELSE 'Excel' END AS ファイル形式名 ,CASE WHEN output_type = '1' THEN 'プリンタ' ELSE 'ダウンロード' END AS 出力先名 ,CASE WHEN output_type = '1' THEN printer_name ELSE '' END AS printer_name FROM m_print_controls ORDER BY print_control_no


