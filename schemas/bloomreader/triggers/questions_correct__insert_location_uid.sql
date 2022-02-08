-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomreader.questions_correct;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomreader.questions_correct
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_fctn();