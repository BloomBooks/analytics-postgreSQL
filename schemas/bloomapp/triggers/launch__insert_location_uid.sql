-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.launch;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.launch
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_launch_fctn();