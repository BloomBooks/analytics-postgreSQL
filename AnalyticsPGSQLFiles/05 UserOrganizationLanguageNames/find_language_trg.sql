-- Trigger: find_language

-- DROP TRIGGER find_language ON bloomapp.users;

CREATE TRIGGER find_language
    BEFORE INSERT
    ON bloomapp.users
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_language_fctn();