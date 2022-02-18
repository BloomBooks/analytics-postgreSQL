-- DROP FUNCTION common.get_reading_locations(BOOLEAN, DATE, DATE, TEXT, TEXT);

CREATE OR REPLACE FUNCTION common.get_reading_locations(
    p_usebookids BOOLEAN, -- not used but keeps functions calls parallel
	p_from DATE DEFAULT DATE(20000101::TEXT), 
    p_to DATE DEFAULT DATE(30000101::TEXT),
    p_branding TEXT DEFAULT NULL::TEXT, -- not used but keeps functions calls parallel
    p_country TEXT DEFAULT NULL::TEXT -- not used but keeps functions calls parallel
)
RETURNS TABLE (
    country TEXT,
    region TEXT,
    city TEXT,
    cnt BIGINT
) 
LANGUAGE plpgsql AS $function$
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
DECLARE book_id_tuple_array common.book_id_input[];
BEGIN
    -- cast the temp table data as function input for better optimization
    SELECT ARRAY_AGG(
        ROW(t.book_id, t.book_instance_id)::common.book_id_input
    ) FROM temp_book_ids AS t INTO book_id_tuple_array;
    RETURN QUERY
        SELECT *
        FROM common.process_reading_locations(
            book_id_tuple_array,
            p_from,
            p_to
        );
END;
$function$;