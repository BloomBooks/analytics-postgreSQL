-- Trigger: insert_location_data

-- DROP TRIGGER IF EXISTS insert_location_data ON bloomreaderbeta.comprehension;

CREATE TRIGGER insert_location_data
    BEFORE INSERT
    ON bloomreaderbeta.comprehension
    FOR EACH ROW
    EXECUTE FUNCTION public.find_closest_city_and_location_uid_fctn();