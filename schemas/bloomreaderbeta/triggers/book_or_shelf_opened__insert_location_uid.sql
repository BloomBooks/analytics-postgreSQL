-- Trigger: insert_location_data

-- DROP TRIGGER IF EXISTS insert_location_data ON bloomreaderbeta.book_or_shelf_opened;

CREATE TRIGGER insert_location_data
    BEFORE INSERT
    ON bloomreaderbeta.book_or_shelf_opened
    FOR EACH ROW
    EXECUTE FUNCTION public.find_closest_city_and_location_uid_fctn();