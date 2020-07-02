-- DROP FUNCTION public.get_book_events(DATE, DATE);

CREATE OR REPLACE FUNCTION public.get_book_events(
        p_branding TEXT, p_country TEXT,
	p_from DATE DEFAULT DATE(20000101::TEXT), p_to DATE DEFAULT DATE(30000101::TEXT))
    RETURNS TABLE (dateLocal DATE, bookBranding VARCHAR, country VARCHAR, bloomReaderSessions INT)
AS $$

DECLARE

BEGIN
        RETURN QUERY    

        SELECT  r.time_local::date as date_local,
                CAST(r.book_branding AS VARCHAR),
                CAST(r.country AS VARCHAR),
                CAST(count(*) AS INT) as number_sessions
        FROM    bloomreader.v_pages_read r
        WHERE   (p_branding IS NULL OR r.book_branding = p_branding) AND
                (p_country IS NULL OR r.country = p_country) AND        
                date_local >= DATE(20000101::TEXT) AND 
                date_local <= DATE(30000101::TEXT)
        group by r.time_local::date,
                r.book_branding,
                r.country;
END; $$


LANGUAGE 'plpgsql';