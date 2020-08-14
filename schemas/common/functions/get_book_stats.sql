-- DROP FUNCTION common.get_book_stats(VARCHAR, VARCHAR, DATE, DATE);

CREATE OR REPLACE FUNCTION common.get_book_stats(
	p_bookId VARCHAR, p_bookInstanceId VARCHAR, p_from DATE DEFAULT DATE(20000101::TEXT), p_to DATE DEFAULT DATE(30000101::TEXT))
    RETURNS TABLE (bookId VARCHAR, totalReads INT, bloomReaderReads INT, bloomLibraryReads INT, totalDownloads INT, shellDownloads INT, libraryViews INT, deviceCount INT)
AS $$

-- For now, just ignoring timestamp because we don't have a use case in which we are filtering for it yet,
-- and it is likey a performance drag.

DECLARE

BEGIN
        SELECT  count(*),
                count(distinct pr.device_unique_id) 
        INTO    bloomReaderReads, 
                deviceCount
        FROM    common.mv_pages_read pr
        WHERE   pr.source = 'bloomreader' AND
                pr.book_instance_id = p_bookInstanceId --AND
                --pr.time_utc BETWEEN p_from AND (p_to + interval '1 day')
        ;

        SELECT  count(*)
                INTO libraryViews
        FROM    common.mv_book_detail bd
        WHERE   bd.book_id = p_bookId --AND
                --bd.timestamp BETWEEN p_from AND (p_to + interval '1 day')
        ;

        DROP TABLE IF EXISTS downloads;
        CREATE TEMP TABLE downloads AS
        SELECT  d.event_type, 
                count(d.event_type) AS cnt
        FROM    common.mv_download_book d
        WHERE   d.book_id = p_bookId --AND
                --d.timestamp BETWEEN p_from AND (p_to + interval '1 day')
        GROUP BY d.event_type;
        SELECT  cnt
        INTO    bloomLibraryReads
        FROM    downloads 
        WHERE   event_type = 'read';
        SELECT  cnt
        INTO    shellDownloads
        FROM    downloads 
        WHERE   event_type = 'shell';
        SELECT  cnt
        INTO    totalDownloads
        FROM    downloads 
        WHERE   event_type <> 'read';

        RETURN QUERY

        SELECT  p_bookId,
                COALESCE(bloomLibraryReads, 0) + COALESCE(bloomReaderReads, 0) AS totalReads,
                COALESCE(bloomReaderReads, 0),
                COALESCE(bloomLibraryReads, 0),
                COALESCE(totalDownloads, 0),
                COALESCE(shellDownloads, 0),
                COALESCE(libraryViews, 0),
                COALESCE(deviceCount, 0)
        ;


--     RETURN QUERY
    
--     WITH    downloads AS 
--             (SELECT d.event_type, 
--                     count(d.event_type) AS cnt
--             FROM    bloomlibrary_org.v_download_book d
--             WHERE   d.book_id = p_bookId --AND
--                     --d.timestamp BETWEEN p_from AND (p_to + interval '1 day')
--             GROUP BY d.event_type
--             ),
--             bloomReaderOpens AS
--             (SELECT count(*) AS cnt,
--                     count(distinct o.device_unique_id) deviceCount
--             FROM    bloomreader.v_book_or_shelf_opened o
--             WHERE   o.book_instance_id = p_bookInstanceId --AND
--                     --o.time_utc BETWEEN p_from AND (p_to + interval '1 day')
--             ),
--             bookDetailViews AS
--             (SELECT count(*) AS cnt
--             FROM    bloomlibrary_org.v_book_detail bd
--             WHERE   bd.book_id = p_bookId --AND
--                     --bd.timestamp BETWEEN p_from AND (p_to + interval '1 day')
--             )
--     SELECT  cast (p_bookId AS TEXT),
--             cast (COALESCE((SELECT cnt FROM bloomReaderOpens), 0) + COALESCE((SELECT cnt FROM downloads WHERE event_type = 'read'), 0) AS INT) AS totalReads,
--             cast (COALESCE((SELECT SUM(cnt) FROM downloads WHERE event_type <> 'read'), 0) AS INT) AS totalDownloads,
--             cast (COALESCE((SELECT cnt FROM bloomReaderOpens), 0) AS INT) AS bloomReaderReads,
--             cast (COALESCE((SELECT bloomReaderOpens.deviceCount FROM bloomReaderOpens), 0) AS INT) AS deviceCount,
--             cast (COALESCE((SELECT cnt FROM downloads WHERE event_type = 'shell' OR event_type IS NULL), 0) AS INT) AS shellDownloads,
--             cast (COALESCE((SELECT cnt FROM bookDetailViews), 0) AS INT) AS libraryViews
--     ;
END; $$

LANGUAGE 'plpgsql';