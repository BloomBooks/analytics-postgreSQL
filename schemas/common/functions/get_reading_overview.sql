-- DROP FUNCTION common.get_reading_overview(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_overview(
    p_usebookids boolean,
    p_from date DEFAULT ((20000101)::TEXT)::date,
    p_to date DEFAULT ((30000101)::TEXT)::date,
    p_branding TEXT DEFAULT NULL::TEXT,
    p_country TEXT DEFAULT NULL::TEXT
) RETURNS TABLE (
    bookcount bigint,
    languagecount bigint,
    topiccount bigint,

    -- These device counts are obsolete but must remain until 
    -- related changes are deployed in blorg.
    devicemobilecount bigint,
    devicepccount bigint,

    userappcount bigint,
    userbloomreadercount bigint,
    userbloompubviewercount bigint,
    userwebcount bigint,

    downloadsepubcount bigint,
    downloadsbloompubcount bigint,
    downloadspdfcount bigint,
    downloadsshellbookscount bigint,

    readsbloomreadercount bigint,
    readswebcount bigint,
    readsappscount bigint,

    countrycount bigint
) LANGUAGE plpgsql AS $function$
/*
 * This wrapper function will aggregrate & cast temp table data (if being
 * used), then handoff to a child processing function to return general
 * stats on reading data.
 * NOTE: The intentional nesting of a child processing function is for the
 * sake of helping the optimizer with a function which uses joins on temp
 * table data by explicitly passing cast data. Without nesting & passing to
 * a child function, this function historically took 20-30s to complete
 * with a single-row, two column temp table of book ID input data.
 */
DECLARE b_input common.book_id_input[];
BEGIN
    IF p_usebookids THEN
        -- cast the temp table data as function input for better optimization
        SELECT ARRAY_AGG(
            ROW(t.book_id, t.book_instance_id)::common.book_id_input
        ) FROM temp_book_ids AS t INTO b_input;
    END IF;
    RETURN QUERY
        SELECT *
        FROM common.process_reading_overview(
            b_input,        -- null & ignored if not required
            p_useBookIds,
            p_from,
            p_to,
            p_branding,     -- null & ignored if not required
            p_country       -- null & ignored if not required
        );
END;
$function$;