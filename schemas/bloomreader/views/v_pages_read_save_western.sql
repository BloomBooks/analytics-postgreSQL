-- View: bloomreader.v_pages_read_save_western

-- DROP VIEW bloomreader.v_pages_read_save_western;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_save_western AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-WesternProvinceELearning-2020' AND
        source = 'bloomreader'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_save_western TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_save_western TO readbloom;
GRANT SELECT ON TABLE bloomreader.v_pages_read_save_western TO bloomreader_save_western;