-- SQL_BEFORE_PROCESS_COUNT
SELECT acceptance_quantity FROM t_process_acceptances WHERE management_no = CAST(? as INT) AND process_sort_no = (CAST(? as INT) - 1) AND partial_delivery_no = CAST(? as INT)
