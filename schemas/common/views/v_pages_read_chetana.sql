-- View: common.v_pages_read_chetana

-- DROP VIEW common.v_pages_read_chetana;

CREATE OR REPLACE VIEW common.v_pages_read_chetana AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'Chetana-Trust'
;

GRANT SELECT ON TABLE common.v_pages_read_chetana TO read_chetana;
GRANT SELECT ON TABLE common.v_pages_read_chetana TO readbloom;
