-- H34/596
UPDATE t_deadline_response_requests SET has_response_request = false ,demand_DATE = CAST(? AS DATE) ,response_deadline = CAST(? AS TIMESTAMP) ,comment = ? ,upDATEd_at = CAST(? AS TIMESTAMP) ,upDATEd_by = ? WHERE management_no = ? AND has_response_request = true


