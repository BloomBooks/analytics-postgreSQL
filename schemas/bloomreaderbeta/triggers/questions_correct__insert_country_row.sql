-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomreaderbeta.questions_correct;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomreaderbeta.questions_correct
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_context_ip_country_bloom_fctn();