-- SQL_GET_MEMO
SELECT kogo ,prospected_quantity_per_quarter ,fiscal_year_prospected_quantity ,deadline FROM m_delivery_memos WHERE kogo = ? AND CURRENT_DATE BETWEEN valid_start_DATE AND valid_end_DATE


