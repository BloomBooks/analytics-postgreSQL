-- DROP FUNCTION common.process_reading_locations(common.book_id_input[], DATE, DATE);

CREATE OR REPLACE FUNCTION common.process_reading_locations(
    book_id_tuple_array common.book_id_input[],
    p_from date DEFAULT ((20000101)::TEXT)::date,
    p_to date DEFAULT ((30000101)::TEXT)::date
) RETURNS TABLE (
    country TEXT,
    country_code TEXT,
    region TEXT,
    city TEXT,
    city_latitude_gps NUMERIC,
    city_longitude_gps NUMERIC,
    cnt BIGINT
) LANGUAGE plpgsql AS $function$
/*
 * This processing logic for common.get_reading_locations() returns location
 * stats on reading data. The calling function must aggregate & cast temp
 * table data for passing to this child function to trigger the optimizer for
 * related joins. If temp table data is not used, this extra step is useless,
 * but all processing logic is stil kept in one place for the sake of clarity.
 */
BEGIN
    RETURN QUERY
        -- a single unnest not required, but added for the sake of clarity
        -- provides book ID data for JOINs below
        WITH b AS (
            SELECT * FROM UNNEST(book_id_tuple_array)
        ),
        reads AS (
            SELECT
                r.book_instance_id,
                -- prefer the geo (from GPS) data if we have it
                COALESCE(r.country_geo, r.country) AS country,
                COALESCE(r.country_code_geo, r.country_code) AS country_code,
                COALESCE(r.region_geo, r.region) AS region,
                COALESCE(r.city_geo, r.city) AS city,
                r.city_latitude_geo AS city_latitude_gps,
                r.city_longitude_geo AS city_longitude_gps
            FROM common.mv_pages_read AS r
            INNER JOIN b ON
                r.book_instance_id = b.book_instance_id
            WHERE
                r.date_local BETWEEN p_from AND p_to
        )
        SELECT
            CAST(r.country AS TEXT) AS country,
            CAST(r.country_code AS TEXT) AS country_code,
            CAST(r.region AS TEXT) AS region,
            CAST(r.city AS TEXT) AS city,
            r.city_latitude_gps AS city_latitude_gps,
            r.city_longitude_gps AS city_longitude_gps,
            count(*) AS cnt
        FROM 
            reads r
        GROUP BY 
            r.country,
            r.country_code,
            r.region,
            r.city,
            -- This is not the ideal. We would like to return one record for 
            -- each city, regardless of whether we have lat/long for it.
            -- But we couldn't figure out how to make that work in this query.
            -- (It would likely take wrapping this in another layer and joining to itself or similar.)
            -- So for now, the blorg client is summing them.
            r.city_latitude_gps,
            r.city_longitude_gps
        ;
END;
$function$;

SELECT common.process_reading_locations(
    ARRAY[
        ROW('F3QIngHh1u', '726d708d-535e-47af-8905-ce6e5e0d745c')::common.book_id_input,
        ROW('F3QIngHh1u', '726d708d-535e-47af-8905-ce6e5e0d745c')::common.book_id_input
    ] , --book_id_tuple_array common.book_id_input[],
    ((20000101)::TEXT)::date,
    ((30000101)::TEXT)::date
)
order by 1;