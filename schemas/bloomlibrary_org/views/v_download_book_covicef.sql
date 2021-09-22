-- View: bloomlibrary_org.v_download_book_covicef

-- DROP VIEW bloomlibrary_org.v_download_book_covicef;

CREATE OR REPLACE VIEW bloomlibrary_org.v_download_book_covicef AS

SELECT  *
FROM    common.mv_download_book
WHERE   book_branding = 'PNG-COVICEF'
;

GRANT SELECT ON bloomlibrary_org.v_download_book_covicef TO bloomreader_inclusiv;