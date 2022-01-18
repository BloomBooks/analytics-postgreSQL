-- DROP FUNCTION public.hex_to_int(hexval varchar);

CREATE OR REPLACE FUNCTION hex_to_int(hexval varchar) RETURNS decimal(38,0) AS $$
DECLARE
    result  int;
BEGIN
    EXECUTE 'SELECT x''' || hexval || '''::int' INTO result;
    RETURN result;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;


