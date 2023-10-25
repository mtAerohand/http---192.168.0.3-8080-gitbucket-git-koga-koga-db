SELECT CASE WHEN account_payable_closing_month < ? THEN 0 
WHEN account_payable_closing_month = ? AND account_payable_closing_type = '1' THEN 2
ELSE 1
END AS 判定
FROM m_systems
