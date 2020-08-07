-- DROP FUNCTION common.get_reading_perbook_base_ events(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_perbook_base_events(
        p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
        p_to DATE DEFAULT DATE(30000101::TEXT),
        p_branding TEXT DEFAULT NULL, 
        p_country TEXT DEFAULT NULL)
    RETURNS TABLE (
            bookInstanceId TEXT,
            bookTitle TEXT, 
            bookBranding TEXT, 
            language TEXT, 
            started BIGINT, 
            finished BIGINT)

AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
        RETURN QUERY    

        SELECT  mv.book_instance_id AS bookInstanceId,
                max(book_title),
                max(mv.book_branding),
                max(book_language_code),
                CAST(sum(mv.started) AS BIGINT), 
                CAST(sum(mv.finished) AS BIGINT)
        FROM    common.mv_reading_perbook_events mv,
                temp_book_ids b
        WHERE   mv.book_instance_id = b.book_instance_id AND
                mv.date_local >= p_from AND 
                mv.date_local <= p_to
        GROUP BY mv.book_instance_id
        ;

ELSE
        RETURN QUERY    

        SELECT  mv.book_instance_id AS bookInstanceId,
                max(book_title),
                max(mv.book_branding),
                max(book_language_code),
                CAST(sum(mv.started) AS BIGINT), 
                CAST(sum(mv.finished) AS BIGINT)
        FROM    common.mv_reading_perbook_events mv
        WHERE   (p_branding IS NULL OR mv.book_branding = p_branding) AND
                (p_country IS NULL OR mv.country = p_country) AND        
                mv.date_local >= p_from AND 
                mv.date_local <= p_to
        GROUP BY mv.book_instance_id
        ;
END IF;
END; $$


LANGUAGE 'plpgsql';