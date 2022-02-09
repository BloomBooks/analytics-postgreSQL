-- Search the geography_city_centers table to find the city whose center is closest to the
-- incoming latitude and longitude.  The bound parameter limits how far away (in degrees)
-- to search for city locations.
CREATE OR REPLACE FUNCTION public.NearestTownOf500(myLatitude numeric, myLongitude numeric, bound numeric)
	RETURNS bigint AS $$
DECLARE
	closest bigint;
	myLocation public.geometry;
BEGIN
	SELECT public.ST_POINT(myLongitude, myLatitude) INTO myLocation;
	SELECT geoid
	FROM public.geography_city_centers
	WHERE public.ST_DISTANCE(myLocation, geom) < bound
	ORDER BY public.ST_DISTANCE(myLocation, geom)
	LIMIT 1 INTO closest;
	RETURN closest;
END;
$$ LANGUAGE plpgsql;

ALTER TABLE bloomreadertest.comprehension
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreadertest.comprehension.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreadertest.book_or_shelf_opened
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreadertest.book_or_shelf_opened.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreadertest.install_attributed
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreadertest.install_attributed.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreadertest.pages_read
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreadertest.pages_read.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';

-- Remove old triggers since we've changed the trigger names
DROP TRIGGER insert_location_uid ON bloomreadertest.book_or_shelf_opened;
DROP TRIGGER insert_location_uid ON bloomreadertest.pages_read;

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreadertest.book_or_shelf_opened table.
DROP TRIGGER insert_location_data ON bloomreadertest.book_or_shelf_opened;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreadertest.book_or_shelf_opened
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreadertest.pages_read table.
DROP TRIGGER insert_location_data ON bloomreadertest.pages_read;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreadertest.pages_read
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreadertest.comprehension table.
DROP TRIGGER insert_location_data ON bloomreadertest.comprehension;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreadertest.comprehension
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreadertest.install_attributed table.
DROP TRIGGER insert_location_data ON bloomreadertest.install_attributed;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreadertest.install_attributed
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

ALTER TABLE bloomreaderbeta.book_or_shelf_opened
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreaderbeta.book_or_shelf_opened.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreaderbeta.comprehension
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreaderbeta.comprehension.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreaderbeta.install_attributed
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreaderbeta.install_attributed.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreaderbeta.pages_read
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreaderbeta.pages_read.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';

ALTER TABLE bloomreader.book_or_shelf_opened
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreader.book_or_shelf_opened.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreader.comprehension
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreader.comprehension.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreader.install_attributed
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreader.install_attributed.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';
ALTER TABLE bloomreader.pages_read
    ADD COLUMN city_center_id bigint;
COMMENT ON COLUMN bloomreader.pages_read.city_center_id
    IS 'This is calculated from the latitude and longitude using the geography_city_centers table and the postgis extension.';

DROP TRIGGER insert_location_uid ON bloomreaderbeta.book_or_shelf_opened;
DROP TRIGGER insert_location_uid ON bloomreaderbeta.comprehension;
DROP TRIGGER insert_location_uid ON bloomreaderbeta.install_attributed;
DROP TRIGGER insert_location_uid ON bloomreaderbeta.pages_read;
DROP TRIGGER insert_location_uid ON bloomreader.book_or_shelf_opened;
DROP TRIGGER insert_location_uid ON bloomreader.comprehension;
DROP TRIGGER insert_location_uid ON bloomreader.install_attributed;
DROP TRIGGER insert_location_uid ON bloomreader.pages_read;

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreaderbeta.book_or_shelf_opened table.
DROP TRIGGER insert_location_data ON bloomreaderbeta.book_or_shelf_opened;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreaderbeta.book_or_shelf_opened
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreaderbeta.pages_read table.
DROP TRIGGER insert_location_data ON bloomreaderbeta.pages_read;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreaderbeta.pages_read
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreaderbeta.comprehension table.
DROP TRIGGER insert_location_data ON bloomreaderbeta.comprehension;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreaderbeta.comprehension
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

-- Create a trigger dealing with finding the location when adding a row to the
-- bloomreaderbeta.install_attributed table.
DROP TRIGGER insert_location_data ON bloomreaderbeta.install_attributed;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreaderbeta.install_attributed
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

---- Create a trigger dealing with finding the location when adding a row to the
---- bloomreader.book_or_shelf_opened table.
DROP TRIGGER insert_location_data ON bloomreader.book_or_shelf_opened;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreader.book_or_shelf_opened
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

---- Create a trigger dealing with finding the location when adding a row to the
---- bloomreader.pages_read table.
DROP TRIGGER insert_location_data ON bloomreader.pages_read;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreader.pages_read
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

---- Create a trigger dealing with finding the location when adding a row to the
---- bloomreader.comprehension table.
DROP TRIGGER insert_location_data ON bloomreader.comprehension;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreader.comprehension
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();

---- Create a trigger dealing with finding the location when adding a row to the
---- bloomreader.install_attributed table.
DROP TRIGGER insert_location_data ON bloomreader.install_attributed;
CREATE TRIGGER insert_location_data
	BEFORE INSERT
	ON bloomreader.install_attributed
	FOR EACH ROW
	EXECUTE PROCEDURE public.find_closest_city_and_location_uid_fctn();
