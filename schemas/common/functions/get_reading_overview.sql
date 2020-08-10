-- DROP FUNCTION common.get_reading_overview(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_overview(
        p_useBookIds BOOLEAN,
	p_from DATE DEFAULT DATE(20000101::TEXT), 
        p_to DATE DEFAULT DATE(30000101::TEXT),
        p_branding TEXT DEFAULT NULL, 
        p_country TEXT DEFAULT NULL)
    RETURNS TABLE (
        bookCount BIGINT, 
        languageCount BIGINT,
        topicCount BIGINT,

        deviceMobileCount BIGINT, 
        -- deviceCount is the old name for deviceMobileCount
        -- but we have to leave it here until blorg2 gets changed and deployed
        deviceCount BIGINT, 
        -- Currently always 0 because we don't report from the PC app yet.
        devicePCCount BIGINT, 
        
        downloadsEpubCount BIGINT,
        downloadsBloomPubCount BIGINT,
        downloadsPDFCount BIGINT,
        downloadsShellbooksCount BIGINT,
        
        readsBloomReaderCount BIGINT,
        -- bloomReaderReadCount is the old name for readsBloomReaderCount
        -- but we have to leave it here until blorg2 gets changed and deployed
        bloomReaderReadCount BIGINT,
        readsWebCount BIGINT,
        -- Currently always 0 because we don't report from apps yet.
        readsAppsCount BIGINT
        )
AS $$

DECLARE

BEGIN

IF p_useBookIds
THEN
    RETURN QUERY

        WITH    downloads AS
                (SELECT d.event_type, 
                        count(d.event_type) AS cnt
                FROM    common.mv_download_book d,
                        temp_book_ids b
                WHERE   d.book_id = b.book_id AND
                        -- we would normally use date_local,
                        -- but the web events don't include timezone
                        d.time_utc >= p_from AND 
                        d.time_utc <= p_to
                GROUP BY d.event_type),
                downloadDistinctIds AS
                (SELECT DISTINCT d.book_instance_id
                FROM    common.mv_download_book d,
                        temp_book_ids b
                WHERE   d.book_id = b.book_id AND
                        -- we would normally use date_local,
                        -- but the web events don't include timezone
                        d.time_utc >= p_from AND 
                        d.time_utc <= p_to),
                bloomReaderReads AS
                (SELECT r.book_instance_id,
                        r.device_unique_id,
                        r.book_language_code
                FROM    common.mv_pages_read r,
                        temp_book_ids b
                WHERE   r.book_instance_id = b.book_instance_id AND
                        r.date_local >= p_from AND 
                        r.date_local <= p_to)
        SELECT  (SELECT COUNT(DISTINCT u.book_instance_id)
                FROM    (SELECT downloadDistinctIds.book_instance_id from downloadDistinctIds
                        UNION ALL
                        SELECT DISTINCT bloomReaderReads.book_instance_id from bloomReaderReads) u) AS bookCount,
                COUNT(DISTINCT r.book_language_code) AS languageCount,
                (SELECT COUNT(DISTINCT topic)
                FROM    common.mv_download_book d,
                        temp_book_ids b
                WHERE   d.book_id = b.book_id AND
                        -- we would normally use date_local,
                        -- but the web events don't include timezone
                        d.time_utc >= p_from AND 
                        d.time_utc <= p_to) AS topicCount,
                COUNT(DISTINCT r.device_unique_id) AS deviceMobileCount,
                COUNT(DISTINCT r.device_unique_id) AS deviceCount,
                CAST(0 AS BIGINT) AS devicePCCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'epub'), 0) AS downloadsEpubCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'bloompub'), 0) AS downloadsBloomPubCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'pdf'), 0) AS downloadsPdfCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'shell'), 0) AS downloadsShellbooksCount,
                COUNT(*) AS readsBloomReaderCount,
                COUNT(*) AS bloomReaderReadCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'read'), 0) AS readsWebCount,
                CAST(0 AS BIGINT) AS readsAppsCount
        FROM    bloomReaderReads r
        ;

ELSE
        RETURN QUERY    


        WITH    downloads AS
                (SELECT d.event_type, 
                        count(d.event_type) AS cnt
                FROM    common.mv_download_book d
                WHERE   (p_branding IS NULL OR d.book_branding = p_branding) AND
                        (p_country IS NULL OR d.country = p_country) AND
                        -- we would normally use date_local,
                        -- but the web events don't include timezone
                        d.time_utc >= p_from AND 
                        d.time_utc <= p_to
                GROUP BY d.event_type),
                downloadDistinctIds AS
                (SELECT DISTINCT d.book_instance_id
                FROM    common.mv_download_book d
                WHERE   (p_branding IS NULL OR d.book_branding = p_branding) AND
                        (p_country IS NULL OR d.country = p_country) AND
                        -- we would normally use date_local,
                        -- but the web events don't include timezone
                        d.time_utc >= p_from AND 
                        d.time_utc <= p_to),
                bloomReaderReads AS
                (SELECT r.book_instance_id,
                        r.device_unique_id,
                        r.book_language_code
                FROM    common.mv_pages_read r
                WHERE   (p_branding IS NULL OR r.book_branding = p_branding) AND
                        (p_country IS NULL OR r.country = p_country) AND
                        r.date_local >= p_from AND 
                        r.date_local <= p_to)
        SELECT  (SELECT COUNT(DISTINCT u.book_instance_id)
                FROM    (SELECT downloadDistinctIds.book_instance_id from downloadDistinctIds
                        UNION ALL
                        SELECT DISTINCT bloomReaderReads.book_instance_id from bloomReaderReads) u) AS bookCount,
                COUNT(DISTINCT r.book_language_code) AS languageCount,
                (SELECT COUNT(DISTINCT topic)
                FROM    common.mv_download_book d
                WHERE   (p_branding IS NULL OR d.book_branding = p_branding) AND
                        (p_country IS NULL OR d.country = p_country) AND
                        -- we would normally use date_local,
                        -- but the web events don't include timezone
                        d.time_utc >= p_from AND 
                        d.time_utc <= p_to) AS topicCount,
                COUNT(DISTINCT r.device_unique_id) AS deviceMobileCount,
                COUNT(DISTINCT r.device_unique_id) AS deviceCount,
                CAST(0 AS BIGINT) AS devicePCCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'epub'), 0) AS downloadsEpubCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'bloompub'), 0) AS downloadsBloomPubCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'pdf'), 0) AS downloadsPdfCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'shell'), 0) AS downloadsShellbooksCount,
                COUNT(*) AS readsBloomReaderCount,
                COUNT(*) AS bloomReaderReadCount,
                COALESCE((SELECT cnt
                FROM    downloads
                WHERE   event_type = 'read'), 0) AS readsWebCount,
                CAST(0 AS BIGINT) AS readsAppsCount
        FROM    bloomReaderReads r
        ;

END IF;
END; $$


LANGUAGE 'plpgsql';