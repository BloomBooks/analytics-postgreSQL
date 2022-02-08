-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.create_book;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.create_book
    FOR EACH ROW
    EXECUTE FUNCTION public.find_location_uid_4_create_book_fctn();