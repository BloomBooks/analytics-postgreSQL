-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomlibrary_org.search_failed;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomlibrary_org.search_failed
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_fctn();