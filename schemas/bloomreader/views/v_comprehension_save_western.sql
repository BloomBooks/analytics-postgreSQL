-- View: bloomreader.v_comprehension_save_western

-- DROP VIEW bloomreader.v_comprehension_save_western;

CREATE OR REPLACE VIEW bloomreader.v_comprehension_save_western AS

SELECT  *
FROM    common.mv_comprehension
WHERE   book_branding = 'PNG-WesternProvinceELearning-2020' AND
        source = 'bloomreader'
;

GRANT SELECT ON TABLE bloomreader.v_comprehension_save_western TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_comprehension_save_western TO readbloom;
GRANT SELECT ON TABLE bloomreader.v_comprehension_save_western TO bloomreader_save_western;
