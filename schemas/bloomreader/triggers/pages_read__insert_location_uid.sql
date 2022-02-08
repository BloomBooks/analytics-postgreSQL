-- Trigger: insert_location_data

-- DROP TRIGGER IF EXISTS insert_location_data ON bloomreader.pages_read;

CREATE TRIGGER insert_location_data
    BEFORE INSERT
    ON bloomreader.pages_read
    FOR EACH ROW
    EXECUTE FUNCTION public.find_closest_city_and_location_uid_fctn();