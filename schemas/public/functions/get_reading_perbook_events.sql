-- DROP FUNCTION public.get_reading_perbook_events(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION public.get_reading_perbook_events(
        p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
        p_to DATE DEFAULT DATE(30000101::TEXT),
        p_branding TEXT DEFAULT NULL, 
        p_country TEXT DEFAULT NULL)
    RETURNS TABLE (bookTitle VARCHAR, bookBranding VARCHAR, language VARCHAR, started BIGINT, finished BIGINT)
AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
    RETURN QUERY

--     select  r.date_local,
--             CAST(r.book_branding AS VARCHAR),
--             CAST(r.country AS VARCHAR),
--             CAST(count(*) AS INT) as number_sessions
--     from    bloomreader.v_pages_read r,
--             temp_book_ids b
--     WHERE   r.book_instance_id = b.book_instance_id AND
--             r.date_local >= p_from AND 
--             r.date_local <= p_to
--     group by r.date_local,
--             r.book_branding,
--             r.country;
select 1;

ELSE
        RETURN QUERY    

        SELECT  --MIN(r.book_title),
                CAST(MODE() WITHIN GROUP (ORDER BY r.book_title) AS VARCHAR) AS book_title,
                CAST(r.book_branding AS VARCHAR),
                CAST(MODE() WITHIN GROUP (ORDER BY r.book_language_code) AS VARCHAR) AS book_language_code,
                count(*) started, 
                sum(r.finished_reading_book::int) finished
        FROM    bloomreader.v_pages_read r
        WHERE   (p_branding IS NULL OR r.book_branding = p_branding) AND
                (p_country IS NULL OR r.country = p_country) AND        
                r.date_local >= p_from AND 
                r.date_local <= p_to
        group by r.book_instance_id,
                r.book_branding;
END IF;
END; $$


LANGUAGE 'plpgsql';