-- FUNCTION: public.ip2ipv4(character varying)

-- DROP FUNCTION public.ip2ipv4(character varying);

CREATE OR REPLACE FUNCTION public.ip2ipv4(
	ip character varying)
    RETURNS bigint	-- This is the "IP Number" used by the ip2location data. It takes the IPv4 address in 127.0.0.1 format, assumes it is a 4-digit base 256 number, and converts it to decimal for easier comparison.
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE 
AS $BODY$

DECLARE
  retint bigint;
  ipint text;
  iptemp varchar;  --decimal(39,0);
  retip  varchar;
  newip text;
  colon_occ integer;
  double_colon_position integer;
  num_of_octets integer;
    RestOfIP text;
	Octet1 text; Octet2 text; Octet3 text; Octet4 text;
	Octet5 text; Octet6 text; Octet7 text; Octet8 text;
	aa text; bb text; cc text; dd text; ee text; ff text; 
	gg text; hh text; ii text; jj text; kk text; ll text; 
	mm text; nn text; oo text; pp text;
	a integer; b integer; c integer; d integer; e integer; 
	f integer; g integer; h integer; i integer; j integer; 
	k integer; l integer; m integer; n integer; o integer; 
	p integer; 
BEGIN
	--------
	-- The name is confusing, but this converts from an IP address in standard IPv4 (127.0.0.1) or standard IPv6 (sort of...) formats
	-- and converts it to the "IP Number" used in the ip2location and ipv42location tables.
	--------

	
  	IF (STRPOS(ip,'<') > 0)  THEN
  		retip:='0.0.0.0';
        EXECUTE format('SELECT inet %L - %L', retip, '0.0.0.0') into retint;
		return retint;
  	END IF;
	IF STRPOS(ip,'.') > 0 THEN
		IF STRPOS(ip,',') > 0 THEN
			retip:=ip; 
			SELECT reverse(split_part(reverse(retip), ',', 1)) into retip;
			EXECUTE format('SELECT inet %L - %L', retip, '0.0.0.0') into retint;
			return retint;
		ELSE 
	  		retip:=ip;   
        	EXECUTE format('SELECT inet %L - %L', retip, '0.0.0.0') into retint;
			return retint;
		END IF;
	ELSE
         IF STRPOS(ip,':') > 0 THEN
		 	-- Note (2022-01-31):
			-- Handles IPv6 (sort of).
			-- This code assumes the IPv6 address is in valid 6to4 notation, and deciphers it accordingly
			-- In this notation, Octet8 (note: not actually an octet. Represents the left-most segment) should contain decimal 2002,
			-- and Octet7 and Octet6 encode the IPv4 address.
			-- All other "octets" (segments) should be 0.
			-- However, this code does not verify if the IPv6 address is actually a 6to4 address,
			-- and will just blindly convert any IPv6 using the 6to4 algorithm even if it's not a 6to4 notation address.
			-- If you look up the result in ipv42location, you will not get the correct location out.
	  		BEGIN
	  			colon_occ:=7;
				RestOfIP := ip;
	    		SELECT COUNT(*) FROM regexp_matches(ip,':','g') into colon_occ;
				IF colon_occ < 7 THEN
		  			IF colon_occ = 6 THEN
			 			SELECT (replace(ip, '::', ':0:0:')) into RestOfIP;
		  			ELSE
		     			IF colon_occ = 5 THEN
		        			SELECT (replace(ip, '::', ':0:0:0:')) into RestOfIP;
		     			END IF;
		  			END IF;
	    		END IF; 
	  		SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet8 ;   
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet8)+1))) into RestOfIP ;
		
			SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet7 ;
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet7)+1))) into RestOfIP ;
		
			SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet6 ;
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet6)+1))) into RestOfIP ;
		
			SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet5 ;
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet5)+1))) into RestOfIP ;
		
			SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet4 ;
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet4)+1))) into RestOfIP ;

			SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet3 ;
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet3)+1))) into RestOfIP ;

			SELECT(SUBSTRING(RestOfIP,1,STRPOS(RestOfIP,':')-1)) into Octet2 ;
			SELECT(RIGHT(RestOfIP,-(LENGTH (Octet2)+1))) into Octet1 ;	
		
			SELECT(SUBSTRING(Octet7,1,2)) into cc;	SELECT(SUBSTRING(Octet7,3,2)) into dd;
			SELECT(SUBSTRING(Octet6,1,2)) into ee;	SELECT(SUBSTRING(Octet6,3,2)) into ff;
			c:=public.hex_to_int(cc);  d:=public.hex_to_int(dd);	
			e:=public.hex_to_int(ee);  f:=public.hex_to_int(ff);  

			retip := (CAST(c AS varchar)||CAST('.' AS varchar)||CAST(d AS varchar)||CAST('.' AS varchar)||
					  CAST(e AS varchar)||CAST('.' AS varchar)||CAST(f AS varchar));
			END;
		ELSE  
			retip:='0.0.0.0';
			EXECUTE format('SELECT inet %L - %L', retip, '0.0.0.0') into retint;
			return retint;
		END IF;
	 END IF;
	 EXECUTE format('SELECT inet %L - %L', retip, '0.0.0.0') into retint;
     return retint;

EXCEPTION
WHEN others THEN
	return 0;

END;

$BODY$;

ALTER FUNCTION public.ip2ipv4(character varying)
    OWNER TO silpgadmin;




select public.ip2int2('2001:18e8:2:1064:f000::7e8');	
	
select public.ip2int2('2600:1700:8351:280:bcf6:7204:7ec1:a03f');  
SELECT public.ipv62country_name(38023013181400188246114412619316063);
select public.ip2int2('2001:0db8:85a3:0000:0000:8a2e:0370:7334');
SELECT public.ipv62country_name(32113184133163000013846311211552);
select public.ip2int2('2001:0db8:85a3:0000:0000:8a2e:0370');
select public.ip2int2('2001:0db8:85a3:0000:0000:8a2e');
SELECT public.hex_to_int('7334');		
		
SELECT SUBSTRING('2001:0db8:85a3:0000:0000:8a2e:0370:7334',1,STRPOS('2001:0db8:85a3:0000:0000:8a2e:0370:7334',':')-1);

SELECT RIGHT ('2001:0db8:85a3:0000:0000:8a2e:0370:7334', -(LENGTH (
SUBSTRING('2001:0db8:85a3:0000:0000:8a2e:0370:7334',1,STRPOS('2001:0db8:85a3:0000:0000:8a2e:0370:7334',':')-1))+1) );				

So IPv4 gives 73.229.231.52 and Ipv6 gives 2601:283:8200:7b2f:b53b:361:f051:71cf
				