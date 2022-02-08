-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.change_page_layout;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.change_page_layout
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_change_page_layout_fctn();