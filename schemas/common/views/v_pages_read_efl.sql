-- View: common.v_pages_read_efl

-- DROP VIEW common.v_pages_read_efl;

CREATE OR REPLACE VIEW common.v_pages_read_efl AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'Education-For-Life' or book_branding = 'Education-For-Life-SE'
;

GRANT SELECT ON TABLE common.v_pages_read_efl TO read_education_for_life;
GRANT SELECT ON TABLE common.v_pages_read_efl TO readbloom;
