-- SQL_WIDTH
SELECT cut_off_widths FROM m_cut_off_widths WHERE material_diameter_from <= CAST(? as NUMERIC) AND material_diameter_to >= CAST(? as NUMERIC)
