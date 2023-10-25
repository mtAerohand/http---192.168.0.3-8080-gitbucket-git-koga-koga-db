-- SQL_GETRANGE
SELECT non_operate_DATE FROM m_calendars WHERE non_operate_DATE BETWEEN CAST(? as DATE) AND CAST(? as DATE) ORDER BY non_operate_DATE
