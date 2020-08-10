-- DROP FUNCTION common.get_reading_perbook_download_events(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_perbook_download_events(
    p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
    p_to DATE DEFAULT DATE(30000101::TEXT),
    p_branding TEXT DEFAULT NULL, 
    p_country TEXT DEFAULT NULL)
RETURNS TABLE (
    bookInstanceId TEXT,
    bookTitle TEXT,
    bookBranding TEXT,
    shellDownloads BIGINT,
    pdfDownloads BIGINT,
    epubDownloads BIGINT,
    bloompubDownloads BIGINT)

AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
    RETURN QUERY    

    SELECT
        book_instance_id AS bookInstanceId,
        MODE() WITHIN GROUP (ORDER BY book_title) AS bookTitle,
        MODE() WITHIN GROUP (ORDER BY book_branding) AS bookBranding,
        count(CASE WHEN event_type = 'shell' OR event_type = NULL THEN 1 END) AS shellDownloads,
        count(CASE WHEN event_type = 'pdf' THEN 1 END) AS pdfDownloads,
        count(CASE WHEN event_type = 'epub' THEN 1 END) AS epubDownloads,
        count(CASE WHEN event_type = 'bloompub' THEN 1 END) AS bloompubDownloads
    FROM    common.mv_download_book
    WHERE
        book_instance_id IN (SELECT book_instance_id FROM temp_book_ids) AND
        -- we would normally use date_local,
        -- but the web events don't include timezone
        time_utc >= p_from AND 
        time_utc <= p_to
    GROUP BY book_instance_id
    ; 

ELSE
    RETURN QUERY    

    SELECT
        book_instance_id AS bookInstanceId,
        MODE() WITHIN GROUP (ORDER BY book_title) AS bookTitle,
        MODE() WITHIN GROUP (ORDER BY book_branding) AS bookBranding,
        count(CASE WHEN event_type = 'shell' OR event_type = NULL THEN 1 END) AS shellDownloads,
        count(CASE WHEN event_type = 'pdf' THEN 1 END) AS pdfDownloads,
        count(CASE WHEN event_type = 'epub' THEN 1 END) AS epubDownloads,
        count(CASE WHEN event_type = 'bloompub' THEN 1 END) AS bloompubDownloads
    FROM    common.mv_download_book
    WHERE
        (p_branding IS NULL OR book_branding = p_branding) AND
        (p_country IS NULL OR country = p_country) AND
        -- we would normally use date_local,
        -- but the web events don't include timezone
        time_utc >= p_from AND 
        time_utc <= p_to
    GROUP BY book_instance_id
    ; 
END IF;
END; $$


LANGUAGE 'plpgsql';


