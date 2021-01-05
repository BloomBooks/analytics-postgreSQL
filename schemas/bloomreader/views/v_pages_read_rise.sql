-- View: bloomreader.v_pages_read_rise

-- DROP VIEW bloomreader.v_pages_read_rise;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_rise AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-RISE' AND
        source = 'bloomreader'
;

GRANT CONNECT ON DATABASE bloomsegment TO bloomreader_rise;
GRANT USAGE ON SCHEMA bloomreader TO bloomreader_rise;
GRANT SELECT ON bloomreader.v_pages_read_rise TO bloomreader_rise;