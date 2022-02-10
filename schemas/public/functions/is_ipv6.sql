CREATE OR REPLACE FUNCTION public.is_ipv6(ip_address character varying) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$

DECLARE
    is_ipv6 boolean;
BEGIN
    --------
    -- Given an IP address, returns:
    -- * true if it an IPv6 address,
    -- * false if it is an IPv4 address or if the input is invalid.
    --------

    RETURN family(inet(ip_address)) = 6;
EXCEPTION
    WHEN others then
        RETURN false;
END;
$$;

ALTER FUNCTION public.is_ipv6(ip_address character varying) OWNER TO silpgadmin;

-- Unit tests: Make sure that all "pass*" columns return true
SELECT
    public.is_ipv6('192.168.1.1') = false AS pass1,
    public.is_ipv6('a:b:c:d:e:f:0:1') = true AS pass2,
    public.is_ipv6('garbage') = false AS result3
FROM bloomreader.pages_read -- Any valid table will do
LIMIT 1;
