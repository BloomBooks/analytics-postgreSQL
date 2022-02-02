-- This is more-or-less an alias for public.ip2ipv4(). It is here for parallelism with ip_to_ipv6number
-- This converts an IPV4 address into the "IP Number" format defined by ip2location. 
CREATE OR REPLACE FUNCTION public.ip_to_ipv4number(ipv4_address character varying) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	return_ipv4_number bigint;
BEGIN
    -- Well, one difference between this function and public.ip2ipv4()
    -- is that we reject IPv6 input in this one, because public.ip2ipv4() does not deal with IPV6 addresses well.
	IF public.is_ipv6(ipv4_address) THEN
		RAISE exception 'public.ip_to_ipv4number() expected an IPv4 input, but received: %', ipv4_address;		
	END IF;

	SELECT public.ip2ipv4(ipv4_address) into return_ipv4_number;

    RETURN return_ipv4_number;

-- Alternatively to raising an exception, we could return 0, which is what the legacy code does
-- EXCEPTION
-- 	WHEN others THEN
-- 		return 0;
END;
$$;

ALTER FUNCTION public.ip_to_ipv4number(ip_address character varying) OWNER TO silpgadmin;

-- Unit tests: Make sure that all "pass*" columns return true
SELECT
	public.ip_to_ipv4number('202.186.13.4') = 3401190660 AS pass1,	-- worked example from ip2location FAQ
    public.ip_to_ipv4number('192.168.1.1') = 3232235777 AS pass2
FROM bloomreader.pages_read	-- Any valid table will do
LIMIT 1;