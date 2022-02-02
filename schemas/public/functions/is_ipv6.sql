-- Given an IP address, returns true if it an IPv6 address, and false if it is an IPv4 address.
CREATE OR REPLACE FUNCTION public.is_ipv6(ip_address character varying) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$

DECLARE
    is_ipv6 boolean;
BEGIN
    -- An IPv6 address normally contains 8 groups of hex digits separated by 7 colons,
    -- so make this determination based on the presence of colons.
    --
    -- The length is not a foolproof way to make this determination.
    -- An IPv6 address could have as little as 15 characters "1:2:3:4:5:6:7:8"
    -- An IPv4 address could have as many as 15 characters   "255.255.255.255"
    --
    -- The presence of periods is not a good way either.
    -- An IPv6 address can contain an IPv4 address (including periods) embedded in its last segment.


    SELECT STRPOS(ip_address,':') >= 1 INTO is_ipv6; -- Note that PostgreSQL strings are 1-indexed

    -- For now, not bothering with validating that remaining characters are only hex digits, right number of hex digits, etc.

    RETURN is_ipv6;
END;
$$;

ALTER FUNCTION public.is_ipv6(ip_address character varying) OWNER TO silpgadmin;

-- Unit tests: Make sure that all "pass*" columns return true
SELECT
    public.is_ipv6('192.168.1.1') = false AS pass1,
    public.is_ipv6('a:b:c:d:e:f:0:1') = true AS pass2
FROM bloomreader.pages_read -- Any valid table will do
LIMIT 1;
