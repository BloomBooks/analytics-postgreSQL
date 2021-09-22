-- View: bloomreader.v_pages_read_covicef

-- DROP VIEW bloomreader.v_pages_read_covicef;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_covicef AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-COVICEF'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_covicef TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_covicef TO readbloom;
