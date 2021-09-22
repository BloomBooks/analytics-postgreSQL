-- View: bloomreader.v_comprehension_rise

-- DROP VIEW bloomreader.v_comprehension_rise;

CREATE OR REPLACE VIEW bloomreader.v_comprehension_rise AS

SELECT  *
FROM    common.mv_comprehension
WHERE   book_branding = 'PNG-RISE' AND
        source = 'bloomreader'
;

GRANT SELECT ON TABLE bloomreader.v_comprehension_rise TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_comprehension_rise TO readbloom;
GRANT SELECT ON TABLE bloomreader.v_comprehension_rise TO bloomreader_rise;
