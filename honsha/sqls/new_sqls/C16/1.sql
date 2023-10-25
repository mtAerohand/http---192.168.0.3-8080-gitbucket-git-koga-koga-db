-- SQL_GET_LOGIN
SELECT employee_code,employee_name,type,mail,user_id ,password,department,authority,group_employee_code,print_group_type FROM m_employees WHERE user_id = ?
