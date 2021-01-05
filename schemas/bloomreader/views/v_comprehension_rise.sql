-- View: bloomreader.v_comprehension_rise

-- DROP VIEW bloomreader.v_comprehension_rise;

CREATE OR REPLACE VIEW bloomreader.v_comprehension_rise AS

SELECT  *
FROM    common.mv_comprehension
WHERE   book_branding = 'PNG-RISE' AND
        source = 'bloomreader'
;

GRANT CONNECT ON DATABASE bloomsegment TO bloomreader_rise;
GRANT USAGE ON SCHEMA bloomreader TO bloomreader_rise;
GRANT SELECT ON bloomreader.v_comprehension_rise TO bloomreader_rise;