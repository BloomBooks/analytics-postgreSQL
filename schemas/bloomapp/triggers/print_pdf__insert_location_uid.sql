-- Trigger: insert_location_uid

-- DROP TRIGGER IF EXISTS insert_location_uid ON bloomapp.print_pdf;

CREATE TRIGGER insert_location_uid
    BEFORE INSERT
    ON bloomapp.print_pdf
    FOR EACH ROW
    EXECUTE FUNCTION public.find_ip_location_uid_fctn();