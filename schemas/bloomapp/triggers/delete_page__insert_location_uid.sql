-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.delete_page;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.delete_page
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_delete_page_fctn();