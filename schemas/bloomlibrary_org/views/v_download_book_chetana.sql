-- View: bloomlibrary_org.v_download_book_chetana

-- DROP VIEW bloomlibrary_org.v_download_book_chetana;

CREATE OR REPLACE VIEW bloomlibrary_org.v_download_book_chetana AS

SELECT  *
FROM    common.mv_download_book
WHERE   book_branding = 'Chetana-Trust'
;

GRANT SELECT ON bloomlibrary_org.v_download_book_chetana TO read_chetana;