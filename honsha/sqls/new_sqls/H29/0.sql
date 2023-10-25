-- SQL_GET_PARAM
SELECT '1' AS type ,CASE WHEN account_payable_closing_type = '1' THEN account_payable_closing_month ELSE LEFT(TO_CHAR(CAST(account_payable_closing_month || '01' as DATE) + interval '1 month','YYYYMMDD'),6) END AS 締め月 ,CASE WHEN account_payable_closing_type = '1' THEN '済' ELSE '' END AS 状態 ,CASE WHEN account_payable_closing_type = '1' THEN suspense_closing_DATEtime ELSE NULL END AS 実行日時 ,version_no FROM m_systems WHERE seq_no = 1 UNION ALL SELECT '2' AS type ,CASE WHEN account_payable_closing_type = '1' THEN account_payable_closing_month ELSE LEFT(TO_CHAR(CAST(account_payable_closing_month || '01' as DATE) + interval '1 month','YYYYMMDD'),6) END AS 締め月 ,'' AS 状態 ,NULL AS 実行日時 ,version_no FROM m_systems WHERE seq_no = 1 ORDER BY type


