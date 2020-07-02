-- DROP FUNCTION public.get_books_stats(DATE, DATE);

CREATE OR REPLACE FUNCTION public.get_books_stats(
	p_from DATE DEFAULT DATE(20000101::TEXT), p_to DATE DEFAULT DATE(30000101::TEXT))
    RETURNS TABLE (dateLocal DATE, bookBranding VARCHAR, country VARCHAR, bloomReaderSessions INT)
    -- RETURNS TABLE (bookId TEXT, bookInstanceId TEXT, bookTitle TEXT, dateLocal DATE)
    --timeOfBloomReaderOpen
    --, totalReads INT, totalDownloads INT, bloomReaderReads INT, deviceCount INT, shellDownloads INT, libraryViews INT)
AS $$

DECLARE

BEGIN
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

    select  r.date_local,
            CAST(r.book_branding AS VARCHAR),
            CAST(r.country AS VARCHAR),
            CAST(count(*) AS INT) as number_sessions
    from    bloomreader.v_pages_read r,
            temp_book_ids b
    WHERE   r.book_instance_id = b.book_instance_id AND
            r.date_local >= p_from AND 
            r.date_local <= p_to
    group by r.date_local,
            r.book_branding,
            r.country;

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
END; $$


LANGUAGE 'plpgsql';