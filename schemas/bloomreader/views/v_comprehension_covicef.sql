-- View: bloomreader.v_comprehension_covicef

-- DROP VIEW bloomreader.v_comprehension_covicef;

CREATE OR REPLACE VIEW bloomreader.v_comprehension_covicef AS

SELECT  *
FROM    common.mv_comprehension
WHERE   book_branding = 'PNG-COVICEF'
;

GRANT SELECT ON TABLE bloomreader.v_comprehension_covicef TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_comprehension_covicef TO readbloom;
