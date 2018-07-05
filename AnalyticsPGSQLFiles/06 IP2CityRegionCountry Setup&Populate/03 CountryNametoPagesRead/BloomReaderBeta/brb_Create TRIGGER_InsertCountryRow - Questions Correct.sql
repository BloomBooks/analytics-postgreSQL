-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomreaderbeta.questions_correct;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomreaderbeta.questions_correct
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_row_fctn();