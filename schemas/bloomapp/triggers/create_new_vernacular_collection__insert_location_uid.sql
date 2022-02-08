-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.create_new_vernacular_collection;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.create_new_vernacular_collection
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_create_new_vernacular_collection_fctn();