-- View: bloomlibrary_org.v_download_book_yrt

-- DROP VIEW bloomlibrary_org.v_download_book_yrt;

CREATE OR REPLACE VIEW bloomlibrary_org.v_download_book_yrt AS

SELECT  *
FROM    common.mv_download_book
WHERE   book_branding = 'PNG-UnrestrICTed-Yumi'
;

GRANT SELECT ON bloomlibrary_org.v_download_book_yrt TO bloomreader_inclusiv;