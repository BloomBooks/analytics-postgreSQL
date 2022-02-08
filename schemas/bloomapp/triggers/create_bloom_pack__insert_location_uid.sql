-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.create_bloom_pack;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.create_bloom_pack
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_create_bloom_pack_fctn();