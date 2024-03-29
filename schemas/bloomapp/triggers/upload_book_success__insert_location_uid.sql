-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.upload_book_success;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.upload_book_success
    FOR EACH ROW
    EXECUTE FUNCTION public.find_ip_location_uid_fctn();