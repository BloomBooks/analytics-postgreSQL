-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomlibrary_org.pages_read;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomlibrary_org.pages_read
    FOR EACH ROW
    EXECUTE FUNCTION public.bl_find_location_uid_4_pages_read_fctn();