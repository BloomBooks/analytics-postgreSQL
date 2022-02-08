-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomreaderbeta.application_opened;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomreaderbeta.application_opened
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_fctn();