CREATE OR REPLACE FUNCTION public.ip_to_ipv6number(ipv6_address character varying) RETURNS numeric(39,0)
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	return_ipv6_number numeric(39,0);
	base numeric(39,0);
	normalized_ipv6_address text;
	segments text[];
BEGIN
	--------
	-- This function converts an IPv6 Address (e.g. '2800:98:1010:ef84:d38a:d0a7:3724:570a')
	-- into the "IP Number" format defined by ip2location. 
	-- The "IP Number" format simplifies lookup in the ipv62location table.
	-- For details, see https://lite.ip2location.com/faq, Section "How do I convert an IPv6 Address to an IP Number"
	--------


	IF NOT public.is_ipv6(ipv6_address) THEN
		RETURN 0;
	END IF;

	SELECT public.normalize_ip(ipv6_address) into normalized_ipv6_address;

	-- Overview:
	-- The IP Number format basically just takes the IP address, which consists of 8 segments of 4 hexadecimal digits,
	-- and thinks of it as a 8-digit base 16^4 number.
	-- Then we convert it to decimal and voila, we have an IP Number which is easy to do range comparison with.


	-- Split the IP Address on delimiter ':' and save as array.
	-- Each entry in the array is a segment of the IP address. The first entry is the left-most segment.
	SELECT regexp_split_to_array(normalized_ipv6_address, ':') INTO segments;
	
	base := 16^4;	-- That is, 65536. It's 16^4 because each group contains 4 hexadecimal characters.

	-- Note: PostgreSQL arrays are 1-indexed.
	--
	-- Note: base should be numeric(39, 0). If you let it use the default,
	-- when you exponentiate, it won't be big enough to store all the significant digits
	-- and all the less-significant digits will get rounded to 0 :(
	SELECT
		public.hex_to_int(segments[1]) * (base ^ 7) +
		public.hex_to_int(segments[2]) * (base ^ 6) +
		public.hex_to_int(segments[3]) * (base ^ 5) +
		public.hex_to_int(segments[4]) * (base ^ 4) +
		public.hex_to_int(segments[5]) * (base ^ 3) +
		public.hex_to_int(segments[6]) * (base ^ 2) +
		public.hex_to_int(segments[7]) * (base ^ 1) +
		public.hex_to_int(segments[8]) * (base ^ 0)
	INTO return_ipv6_number;

    RETURN return_ipv6_number;
EXCEPTION
    -- We just return 0 instead of throwing exceptions because an exception will prevent Segment from completing the sync with Postgres
	WHEN others THEN
		return 0;
END;
$$;

ALTER FUNCTION public.ip_to_ipv6number(ip_address character varying) OWNER TO silpgadmin;

-- Unit test for ip_to_ipv6number
-- Make sure every "pass*" column returns true
SELECT
	public.ip_to_ipv6number('2001:0db8:0000:0042:0000:8a2e:0370:7334') = 42540766411282594074389245746715063092 AS pass1,	-- worked example from ip2location FAQ
	public.ip_to_ipv6number('2001:db8::42:0:8a2e:370:7334') = 42540766411282594074389245746715063092 AS pass2,	-- short form of the worked example
	public.ip_to_ipv6number('255.255.255.255') = 0 AS pass3
FROM bloomreader.pages_read	-- This table name doesn't matter
LIMIT 1;
