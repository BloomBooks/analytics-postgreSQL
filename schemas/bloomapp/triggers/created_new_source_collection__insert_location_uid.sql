-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.created_new_source_collection;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.created_new_source_collection
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_created_new_source_collection_fctn();