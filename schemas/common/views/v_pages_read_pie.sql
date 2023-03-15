-- View: common.v_pages_read_pie

-- DROP VIEW common.v_pages_read_pie;

CREATE OR REPLACE VIEW common.v_pages_read_pie AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-AUS-PIE'
;

GRANT SELECT ON TABLE common.v_pages_read_pie TO read_png_aus_pie;
GRANT SELECT ON TABLE common.v_pages_read_pie TO readbloom;
