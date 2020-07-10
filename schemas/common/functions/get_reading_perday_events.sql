-- DROP FUNCTION common.get_reading_perday_events(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_perday_events(
        p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
        p_to DATE DEFAULT DATE(30000101::TEXT),
        p_branding TEXT DEFAULT NULL, 
        p_country TEXT DEFAULT NULL)
    RETURNS TABLE (dateLocal DATE, bookBranding TEXT, country VARCHAR, bloomReaderSessions BIGINT)
AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
    RETURN QUERY
    
    -- SELECT  b.book_id,
    --         d.book_instance_id,
    --         d.book_title,
    --         d.time_utc
    -- FROM    temp_book_ids b,
    --         bloomreader.v_book_or_shelf_opened d
    -- WHERE   b.book_instance_id = d.book_instance_id
    -- ;
    
    -- SELECT  i.book_id,
    --         d.book_instance_id,
    --         d.book_title,
    --         DATE_TRUNC(d.timestamp) AS date_local
    --         --d.timestamp
    -- FROM    temp_book_ids i,
    --         bloomlibrary_test.v_download_book d
    -- WHERE   i.book_id = d.book_id
    -- GROUP BY date_local
    -- ;

    -- SELECT  count(i.book_id),
    --         d.timestamp::date AS date_local
    -- FROM    temp_book_ids i,
    --         bloomlibrary_test.v_download_book d
    -- WHERE   i.book_id = d.book_id
    -- GROUP BY date_local
    -- ;

    select  mv.date_local,
            mv.book_branding,
            mv.country,
            CAST(sum(mv.number_sessions) AS BIGINT) as number_sessions
    from    common.mv_reading_perday_events mv,
            temp_book_ids b
    WHERE   mv.book_instance_id = b.book_instance_id AND
            mv.date_local >= p_from AND 
            mv.date_local <= p_to
    group by mv.date_local,
            mv.book_branding,
            mv.country;

    -- SELECT  date_local,
    --         book_branding,
    --         country,
    --         number_sessions
    -- FROM    bloomreader.v_sessions_per_day,
    -- ;

    -- SELECT  p_bookId,
    --         p_bookInstanceId,
    --         bookTitle,
    --         date_local
    -- ;
ELSE
        RETURN QUERY    

        SELECT  mv.date_local,
                mv.book_branding,
                mv.country,
                mv.number_sessions
        FROM    common.mv_reading_perday_events_by_branding_and_country mv
        WHERE   (p_branding IS NULL OR mv.book_branding = p_branding) AND
                (p_country IS NULL OR mv.country = p_country) AND        
                mv.date_local >= p_from AND 
                mv.date_local <= p_to
        ;
END IF;
END; $$


LANGUAGE 'plpgsql';