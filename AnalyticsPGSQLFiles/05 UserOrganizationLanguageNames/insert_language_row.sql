-- Trigger: insert_language_row

-- DROP TRIGGER insert_language_row ON bloomapp.users;

CREATE TRIGGER insert_language_row
    BEFORE INSERT
    ON bloomapp.users
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_language_row_fctn();