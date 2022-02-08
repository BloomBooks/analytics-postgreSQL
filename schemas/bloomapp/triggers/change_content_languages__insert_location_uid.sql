-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.change_content_languages;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.change_content_languages
    FOR EACH ROW
    EXECUTE FUNCTION public.find_ip_location_uid_fctn();