-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomlibrary_org.download_book;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomlibrary_org.download_book
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_fctn();