-- Trigger: refresh_mv_comprehension

-- DROP TRIGGER IF EXISTS refresh_mv_comprehension ON bloomreaderbeta.questions_correct;

CREATE CONSTRAINT TRIGGER refresh_mv_comprehension
    AFTER INSERT
    ON bloomreaderbeta.questions_correct
    DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW
    EXECUTE FUNCTION common.refresh_mv_comprehension();

ALTER TABLE bloomreaderbeta.questions_correct
    DISABLE TRIGGER refresh_mv_comprehension;