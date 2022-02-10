CREATE OR REPLACE FUNCTION public.is_ip_valid(ip_address character varying) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    ip_inet inet;
BEGIN
    --------
    -- Returns true if an IP is valid, false otherwise.
    -- Valid means castable to inet
    --------


    ip_inet := inet(ip_address);    -- Throws exception (which we catch) if invalid
    RETURN true;
EXCEPTION
    WHEN others THEN
        RETURN false;
END;
$$;

ALTER FUNCTION public.is_ip_valid(ip_address character varying) OWNER TO silpgadmin;

-- Unit tests: Make sure that all "pass*" columns return true
SELECT
    public.is_ip_valid('192.168.1.1') = true AS pass1,
    public.is_ip_valid('a:b:c:d:e:f:0:1') = true AS pass2,
    public.is_ip_valid('garbage') = false AS result3
FROM ip2location -- Any valid table will do
LIMIT 1;
