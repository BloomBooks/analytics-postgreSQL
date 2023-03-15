-- View: bloomlibrary_org.v_download_book_pie

-- DROP VIEW bloomlibrary_org.v_download_book_pie;

CREATE OR REPLACE VIEW bloomlibrary_org.v_download_book_pie AS

SELECT  *
FROM    common.mv_download_book
WHERE   book_branding = 'PNG-AUS-PIE'
;

GRANT SELECT ON bloomlibrary_org.v_download_book_pie TO read_png_aus_pie;