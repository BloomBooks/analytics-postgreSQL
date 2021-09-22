-- View: bloomreader.v_comprehension_yrt

-- DROP VIEW bloomreader.v_comprehension_yrt;

CREATE OR REPLACE VIEW bloomreader.v_comprehension_yrt AS

SELECT  *
FROM    common.mv_comprehension
WHERE   book_branding = 'PNG-UnrestrICTed-Yumi'
;

GRANT SELECT ON TABLE bloomreader.v_comprehension_yrt TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_comprehension_yrt TO readbloom;
