-- Implement the trigger function for finding the location when inserting a row into any
-- table with latitude, longitude, city_center_id, context_ip, and location_uid columns.
-- If NEW.latitude and NEW.longitude are set, then NEW.city_center_id is set based on those
-- value.  NEW.context_ip is then used to try to guess where the user is, storing the result
-- in NEW.location_uid.
CREATE OR REPLACE FUNCTION public.find_closest_city_and_location_uid_fctn()
	RETURNS trigger AS $$
DECLARE loc_uid_temp bigint;
DECLARE geoid bigint;
BEGIN
	IF NEW.latitude IS NOT NULL AND NEW.longitude IS NOT NULL THEN
		-- search for towns within 1 degree (~69 miles/111 km near the equator)
		SELECT public.NearestTownOf500(NEW.latitude,NEW.longitude,1.0) INTO geoid;
		IF geoid IS NULL THEN
			-- if nothing found, search twice as far for any towns
			SELECT public.NearestTownOf500(NEW.latitude,NEW.longitude,2.0) INTO geoid;
		END IF;
		IF geoid IS NOT NULL THEN
			NEW.city_center_id := geoid;
		END IF;
	END IF;
	--
	-- The rest of this method is essentially unchanged from before, using the ip address
	-- to get the location.
	SELECT *
    FROM public.find_location_uid_helper(NEW.context_ip)
    INTO loc_uid_temp;
	--
	NEW.location_uid := loc_uid_temp;
	--
RETURN NEW;
END;
$$ LANGUAGE plpgsql;