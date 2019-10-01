-- Trigger: insert_country_row

-- DROP TRIGGER insert_country_row ON bloomreader.questions_correct;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomreader.questions_correct
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_context_ip_country_bloom_fctn();