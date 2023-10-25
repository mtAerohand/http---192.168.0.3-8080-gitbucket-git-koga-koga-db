-- SQL_GET_ALL
SELECT supplier_code,manager_code,manager_name,mail,user_id,password,CASE authority WHEN '1' THEN '一般' WHEN '2' THEN '管理者' ELSE '' END AS authority,sort_no,valid_start_DATE,valid_end_DATE FROM m_supplier_managers WHERE supplier_code = ? ORDER BY sort_no, manager_code


