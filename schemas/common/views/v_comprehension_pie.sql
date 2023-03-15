-- View: common.v_comprehension_pie

-- DROP VIEW common.v_comprehension_pie;

CREATE OR REPLACE VIEW common.v_comprehension_pie AS

SELECT  *
FROM    common.mv_comprehension
WHERE   book_branding = 'PNG-AUS-PIE'
;

GRANT SELECT ON TABLE common.v_comprehension_pie TO read_png_aus_pie;
GRANT SELECT ON TABLE common.v_comprehension_pie TO readbloom;
