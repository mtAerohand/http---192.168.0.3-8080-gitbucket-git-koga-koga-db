-- SQL_GET
SELECT non_operate_DATE FROM m_calendars WHERE CAST(DATE_PART('YEAR', non_operate_DATE) AS VARCHAR) = ? AND CAST(DATE_PART('MONTH', non_operate_DATE) AS VARCHAR) = ? ORDER BY non_operate_DATE


