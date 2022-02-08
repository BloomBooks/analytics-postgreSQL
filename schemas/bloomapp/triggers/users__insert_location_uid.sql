-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.users;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.users
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_fctn();