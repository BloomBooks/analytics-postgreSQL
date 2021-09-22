-- View: bloomreader.v_pages_read_rise

-- DROP VIEW bloomreader.v_pages_read_rise;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_rise AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-RISE' AND
        source = 'bloomreader'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_rise TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_rise TO readbloom;
GRANT SELECT ON TABLE bloomreader.v_pages_read_rise TO bloomreader_rise;
