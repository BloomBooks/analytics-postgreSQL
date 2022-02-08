-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomlibrary_org.book_or_shelf_opened;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomlibrary_org.book_or_shelf_opened
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_fctn();