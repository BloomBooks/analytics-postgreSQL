CREATE OR REPLACE FUNCTION common.process_reading_overview(
    b_input common.book_id_input[], -- null & ignored if not required
    p_usebookids boolean,
    p_from date DEFAULT ((20000101)::TEXT)::date,
    p_to date DEFAULT ((30000101)::TEXT)::date,
    p_branding TEXT DEFAULT NULL::TEXT,       -- null & ignored if not required
    p_country TEXT DEFAULT NULL::TEXT         -- null & ignored if not required
) RETURNS TABLE (
    bookcount bigint,
    languagecount bigint,
    topiccount bigint,
    devicemobilecount bigint,
    devicecount bigint,
    devicepccount bigint,
    downloadsepubcount bigint,
    downloadsbloompubcount bigint,
    downloadspdfcount bigint,
    downloadsshellbookscount bigint,
    readsbloomreadercount bigint,
    bloomreaderreadcount bigint,
    readswebcount bigint,
    readsappscount bigint
) LANGUAGE plpgsql AS $function$
/*
 * This processing logic for common.get_reading_overview() returns general
 * stats on reading data. The calling function must aggregate & cast temp
 * table data for passing to this child function to trigger the optimizer for
 * related joins. If temp table data is not used, this extra step is useless,
 * but all processing logic is stil kept in one place for the sake of clarity.
 */
BEGIN
    -- uses book overview input captured from temp table if required
    IF p_usebookids THEN RETURN QUERY
        -- a single unnest not required, but added for the sake of clarity
        -- provides book ID data for JOINs below
        WITH b AS (
            SELECT * FROM UNNEST(b_input)
        ),
        -- shared initial pre-aggregate to isolate common attributes & timeframe
        d AS (
            SELECT
                d.book_id,
                d.book_instance_id,
                d.topic,
                d.event_type,
                d.time_utc
            FROM common.mv_download_book AS d
            INNER JOIN b ON
                d.book_id = b.book_id
            -- we would normally use date_local,
            -- but the web events don't include timezone
            WHERE d.time_utc BETWEEN p_from AND p_to
        ),
        -- unique event_types will be pivoted later into separate columns
        dEvent AS (
            SELECT event_type, COUNT(event_type) AS cnt
            FROM d
            GROUP BY event_type 
        ),
        -- used by final FROM to provide additional aggregates
        bloomReaderReads AS (
            SELECT
                r.book_instance_id,
                r.device_unique_id,
                r.book_language_code
            FROM common.mv_pages_read AS r
            INNER JOIN b ON
                r.book_instance_id = b.book_instance_id
            WHERE
                r."source" = 'bloomreader'
                -- we would normally use date_local,
                -- but the web events don't include timezone
                AND r.date_local BETWEEN p_from AND p_to
        )
        -- final aggregate primarily pivots row data to columnar in single row
        SELECT
            (
                SELECT COUNT(DISTINCT u.book_instance_id)
                FROM (
                        SELECT DISTINCT book_instance_id
                        FROM d
                    UNION ALL
                        SELECT DISTINCT book_instance_id
                        FROM bloomReaderReads
                ) AS u
            ) AS bookCount,
            COUNT(DISTINCT r.book_language_code) AS languageCount,
            (SELECT COUNT(DISTINCT topic) FROM d) AS topicCount,
            COUNT(DISTINCT r.device_unique_id) AS deviceMobileCount,
            COUNT(DISTINCT r.device_unique_id) AS deviceCount,
            CAST(0 AS BIGINT) AS devicePCCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'epub'), 0) AS downloadsEpubCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'bloompub'), 0) AS downloadsBloomPubCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'pdf'), 0) AS downloadsPdfCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'shell'), 0) AS downloadsShellbooksCount,
            COUNT(*) AS readsBloomReaderCount,
            COUNT(*) AS bloomReaderReadCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'read'), 0) AS readsWebCount,
            CAST(0 AS BIGINT) AS readsAppsCount
        FROM bloomReaderReads AS r;
    -- no temp table data required
    ELSE RETURN QUERY
        -- shared initial pre-aggregate to isolate common attributes & timeframe
        WITH d AS (
            SELECT
                d.book_instance_id,
                d.topic,
                d.event_type,
                d.time_utc
            FROM common.mv_download_book AS d
            WHERE
                (p_branding IS NULL OR d.book_branding = p_branding)
                AND (p_country IS NULL OR d.country = p_country)
                -- we would normally use date_local,
                -- but the web events don't include timezone
                AND d.time_utc BETWEEN p_from AND p_to
        ),
        -- unique event_types will be pivoted later into separate columns
        dEvent AS (
            SELECT event_type, COUNT(event_type) AS cnt
            FROM d
            GROUP BY event_type
        ),
        -- used by final FROM to provide additional aggregates
        bloomReaderReads AS (
            SELECT
                r.book_instance_id,
                r.device_unique_id,
                r.book_language_code
            FROM common.mv_pages_read AS r
            WHERE
                r."source" = 'bloomreader'
                AND (p_branding IS NULL OR r.book_branding = p_branding)
                AND (p_country IS NULL OR r.country = p_country)
                AND r.date_local BETWEEN p_from AND p_to
        )
        -- final aggregate primarily pivots row data to columnar in single row
        SELECT
            (
                SELECT COUNT(DISTINCT u.book_instance_id)
                FROM (
                        SELECT DISTINCT book_instance_id
                        FROM d
                    UNION ALL
                        SELECT DISTINCT book_instance_id
                        FROM bloomReaderReads
                ) AS u
            ) AS bookCount,
            COUNT(DISTINCT r.book_language_code) AS languageCount,
            (SELECT COUNT(DISTINCT topic) FROM d) AS topicCount,
            COUNT(DISTINCT r.device_unique_id) AS deviceMobileCount,
            COUNT(DISTINCT r.device_unique_id) AS deviceCount,
            CAST(0 AS BIGINT) AS devicePCCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'epub'), 0) AS downloadsEpubCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'bloompub'), 0) AS downloadsBloomPubCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'pdf'), 0) AS downloadsPdfCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'shell'), 0) AS downloadsShellbooksCount,
            COUNT(*) AS readsBloomReaderCount,
            COUNT(*) AS bloomReaderReadCount,
            COALESCE((SELECT cnt FROM dEvent WHERE event_type = 'read'), 0) AS readsWebCount,
            CAST(0 AS BIGINT) AS readsAppsCount
        FROM bloomReaderReads AS r ;
    END IF;
END;
$function$;