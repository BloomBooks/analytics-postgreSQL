
CREATE OR REPLACE FUNCTION public.update_location_uids(
        table_name regclass,
        ip_column_name text,
        location_column_name text,
        should_update_ipv6_only boolean
    )
    RETURNS void
    LANGUAGE plpgsql VOLATILE
    AS $$
DECLARE
BEGIN
    --------
    -- Given the table name, IP column name, and location_uid column name,
    -- generates a script to update the location_uid of any relevant rows in the table,
    -- and runs it.
    --------


    -- TODO: What happens to rows with invalid IP addresses?

    EXECUTE format('
    UPDATE %1$s AS a
    SET %3$s=b.location_uid
    FROM (
        SELECT
            ip_address,
            public.find_location_uid_helper(ip_address) AS location_uid
        FROM (
            SELECT DISTINCT
                %2$s AS ip_address
            FROM %1$s
            WHERE public.is_ip_valid(%2$s)
        ) AS distinctValidContextIps
        WHERE (NOT %4$L) OR public.is_ipv6(ip_address)
    ) AS b
    WHERE a.%2$s = b.ip_address AND b.location_uid IS NOT NULL AND a.%3$s != b.location_uid
    ;
    ', table_name, ip_column_name, location_column_name, should_update_ipv6_only);
END;
$$;

ALTER FUNCTION public.update_location_uids(table_name regclass, ip_column_name text, location_column_name text, should_update_ipv6_only boolean) OWNER TO silpgadmin;


