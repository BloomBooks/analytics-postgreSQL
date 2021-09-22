-- View: bloomreader.v_pages_read_yrt

-- DROP VIEW bloomreader.v_pages_read_yrt;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_yrt AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-UnrestrICTed-Yumi'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_yrt TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_yrt TO readbloom;
