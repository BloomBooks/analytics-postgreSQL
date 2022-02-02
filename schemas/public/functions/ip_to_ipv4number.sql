-- This is more-or-less an alias for public.ip2ipv4(). It is here for parallelism with ip_to_ipv6number
-- This converts an IPV4 address into the "IP Number" format defined by ip2location. 
CREATE OR REPLACE FUNCTION public.ip_to_ipv4number(ipv4_address character varying) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	return_ipv4_number bigint;
BEGIN
	IF public.is_ipv6(ipv4_address) THEN
        -- IPv6 input
        -- Well, one difference between this function and public.ip2ipv4()
        -- is that we return 0 for IPv6 input in this one, because public.ip2ipv4() does not deal with IPV6 addresses well.
		return_ipv4_number := 0;
    ELSE
        -- IPv4 input
    	SELECT public.ip2ipv4(ipv4_address) into return_ipv4_number;
	END IF;

    RETURN return_ipv4_number;
EXCEPTION
    -- We just return 0 instead of throwing exceptions because an exception will prevent Segment from completing the sync with Postgres
	WHEN others THEN
		return 0;
END;
$$;

ALTER FUNCTION public.ip_to_ipv4number(ip_address character varying) OWNER TO silpgadmin;

-- Unit tests: Make sure that all "pass*" columns return true
SELECT
	public.ip_to_ipv4number('202.186.13.4') = 3401190660 AS pass1,	-- worked example from ip2location FAQ
    public.ip_to_ipv4number('192.168.1.1') = 3232235777 AS pass2,
    public.ip_to_ipv4number('2001:0db8:0000:0042:0000:8a2e:0370:7334') = 0 AS pass3
FROM bloomreader.pages_read	-- Any valid table will do
LIMIT 1;