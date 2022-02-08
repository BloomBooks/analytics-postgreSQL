-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomlibrary_org.open_collection;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomlibrary_org.open_collection
    FOR EACH ROW
    EXECUTE FUNCTION public.bl_find_location_uid_4_open_collection_fctn();