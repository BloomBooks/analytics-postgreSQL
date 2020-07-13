-- DROP FUNCTION common.get_reading_overview(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_overview(
        p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
        p_to DATE DEFAULT DATE(30000101::TEXT),
        p_branding TEXT DEFAULT NULL, 
        p_country TEXT DEFAULT NULL)
    RETURNS TABLE (
        bookCount BIGINT, 
        deviceCount BIGINT, 
        languageCount BIGINT,
        bloomReaderReadCount BIGINT)
AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
    RETURN QUERY

        -- This works on BR and BR Beta, but not BLORG.
        SELECT  COUNT(DISTINCT r.book_instance_id) AS bookCount,
                COUNT(DISTINCT r.device_unique_id) AS deviceCount,
                COUNT(DISTINCT r.book_language_code) AS languageCount,
                COUNT(*) AS bloomReaderReadCount
        FROM    common.mv_pages_read r,
                temp_book_ids b
        WHERE   r.book_instance_id = b.book_instance_id AND
                r.date_local >= p_from AND 
                r.date_local <= p_to
        ;

ELSE
        RETURN QUERY    

        -- This works on BR and BR Beta, but not BLORG.
        SELECT  COUNT(DISTINCT book_instance_id) AS bookCount,
                COUNT(DISTINCT device_unique_id) AS deviceCount,
                COUNT(DISTINCT book_language_code) AS languageCount,
                COUNT(*) AS bloomReaderReadCount
        FROM    common.mv_pages_read r
        WHERE   r.book_branding = p_branding AND
                r.country = p_country AND        
                r.date_local >= p_from AND 
                r.date_local <= p_to
        ;

END IF;
END; $$


LANGUAGE 'plpgsql';