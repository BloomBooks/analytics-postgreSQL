-- View: bloomreader.v_pages_read_save_western

-- DROP VIEW bloomreader.v_pages_read_save_western;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_save_western AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-WesternProvinceELearning-2020' AND
        source = 'bloomreader'
;

GRANT CONNECT ON DATABASE bloomsegment TO bloomreader_save_western;
GRANT USAGE ON SCHEMA bloomreader TO bloomreader_save_western;
GRANT SELECT ON bloomreader.v_pages_read_save_western TO bloomreader_save_western;