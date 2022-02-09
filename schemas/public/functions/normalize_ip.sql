CREATE OR REPLACE FUNCTION public.normalize_ip(ip_address character varying) RETURNS character varying
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	normalized_ipv6 character varying;
	double_colon_index integer;
	num_chars integer;
	num_colon_chars integer;
	num_implicit_zeros integer;
BEGIN
	--------
	-- Normalizes an IP address (e.g. "192.168.1.1" or "2400:ac40:852:471a::1")
	-- Notably, converts IPV6 short form (uses :: as an abbreviation) into something which specifies all the 0's.
	-- Note: Does not currently handle IP v6 "/" suffixes. I don't find this form in our tables.
	--       Nor does it do anything particular with any other IPV6 format variant.
	--------

	
	IF NOT public.is_ipv6(ip_address) THEN
		-- Looks like a v4.
		-- We currently don't have any normalization steps to do for v4. Just return it untouched.
		RETURN ip_address;
	END IF;

	-- Looks like an IPv6 address
	--
	-- Handle short forms (where two colons in a row are shorthand for filling all the missing segments with 0's)
	-- https://www.ibm.com/docs/en/i/7.4?topic=concepts-ipv6-address-formats
	-- Double colons can only be used once, thankfully.
	-- There is indeed some data in our tables that uses short form! Such as: 2400:ac40:852:471a::1

	normalized_ipv6 := ip_address;

	SELECT STRPOS(ip_address,'::'), LENGTH(ip_address) into double_colon_index, num_chars;

	-- Handle :: at beginning of string.
	IF double_colon_index = 1 THEN	-- NOTE: PostgreSQL string functions use 1-indexing, not 0-indexing.
		SELECT concat('0', ip_address) INTO normalized_ipv6;
	-- Handle :: at end of string.
	-- The +1 in the ELSIF condition is to account for the length of '::'
	ELSIF double_colon_index + 1 = num_chars THEN		
		SELECT concat(ip_address, '0') INTO normalized_ipv6;
	END IF;

	SELECT COUNT(*) FROM regexp_matches(ip_address,':','g') into num_colon_chars;
	IF num_colon_chars > 8 THEN
		-- Note: It is possible to have both double colon and for num_colon_chars to be 7, or even 8!
		RAISE warning 'Unexpected ip_address: %', ip_address;
	END IF;
	
	num_implicit_zeros := 7 - num_colon_chars + 1;
	SELECT replace(normalized_ipv6, '::', concat(repeat(':0', num_implicit_zeros), ':'))
	Into normalized_ipv6;

    RETURN normalized_ipv6;
EXCEPTION
	-- if there's an exception, just return the input unchanged.
	WHEN others THEN
		RAISE warning 'public.normalize_ip threw exception on input: %', ip_address;
		return ip_address;
END;
$$;

ALTER FUNCTION public.normalize_ip(ip_address character varying) OWNER TO silpgadmin;

-- Unit tests for normalize_ip()
-- Make sure every column returns true
SELECT
    public.normalize_ip('1:2:3:4:5:6:7:8') = '1:2:3:4:5:6:7:8' AS pass1,
    public.normalize_ip('::2:3:4:5:6:7:8') = '0:2:3:4:5:6:7:8' AS pass2,
    public.normalize_ip(  '::3:4:5:6:7:8') = '0:0:3:4:5:6:7:8' AS pass3,
    public.normalize_ip(    '::4:5:6:7:8') = '0:0:0:4:5:6:7:8' AS pass4,
    public.normalize_ip('1::5:6:7:8') = '1:0:0:0:5:6:7:8' AS pass5,
    public.normalize_ip('1:2:3:4::') = '1:2:3:4:0:0:0:0' AS pass6,
	public.normalize_ip('192.168.1.1') = '192.168.1.1' AS pass7
FROM public.ipv62location   -- Any valid table will do
LIMIT 1
;